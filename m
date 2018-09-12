Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBAC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B3A2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="i1gL1DRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B3A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIMBlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:41:10 -0400
Received: from canardo.mork.no ([148.122.252.1]:57401 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbeIMBlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:41:09 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w8CKYh5A013794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 22:34:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1536784484; bh=nNj30DunZWcHwZ8GRJGKCRa2Q9pKSDc76xAhMiILzIY=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=i1gL1DREB4Qg5+M0yoGf8QmlLmZFTqPSSzgZG7PRc2JTpFVTLebYpGpkeYT0XeeYg
         GD6ZbPTZqzVBMAn0aN/OZL7WWU6zbMARIKBw7YMBvGhXf403ppcrKOdXcvrRS736au
         ZrnGWt59dRZcRDLIbuuWZttfaZbBcDvbogOQuJUA=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1g0BqV-0001Ui-Ct; Wed, 12 Sep 2018 22:34:43 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Lars Melin <larsm17@gmail.com>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
Organization: m
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
        <20180910103022.GR1089@localhost>
        <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
        <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
        <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
        <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
        <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
        <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
        <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com>
Date:   Wed, 12 Sep 2018 22:34:43 +0200
In-Reply-To: <f3c647ec7c50ae390fb92861d492e7aa4bef8c6f.camel@redhat.com> (Dan
        Williams's message of "Wed, 12 Sep 2018 14:18:05 -0500")
Message-ID: <87y3c6a1zw.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dcbw@redhat.com> writes:

> The fact that the firmware implementation has the ability to change the
> endpoints is unrelated to Kristian's case, and that alone is
> justification for this to be quirked in the driver.  People other than
> Kristian will undoubtedly use the functionality, on platforms less
> limited.

FWIW, I agree with Dan and Kristian on this. It's a documented feature,
and it will be used. The reasons are irrelevant. The firmware
implementation is inconvenient, but we should still strive to make it
Just Work in Linux.  Kristian's solution does that.

> Also most Huawei modems have the ability to change their layout and
> configuration just like the EP06 via the U2DIAG and SETPORT commands.

Yes, but they are nice enough to use unique class/subclass/protocol
triplets for their functions so it's easy to support the changing
layout.  At least as long as they use their own VID and not some laptop
vendor's..

The Sierra Wireless strategy, using fixed interface numbers leaving
"holes" is another fine solution to the problem.  Or they could have
allocated unique VIDs per function combination, as long as the number of
valid combinations are low.  But they didn't.  It's not like it's the
first bad firmware design we've had to deal with.  Let's just work
around it, like we always do.  No need to make life difficult for end
users just because Quectel makes life difficult for us.


Bj=C3=B8rn
