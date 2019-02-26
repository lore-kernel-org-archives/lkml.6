Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FA22146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBZKeC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:34:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45170 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBZKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:34:01 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so876915eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JZVneiWN0cnhw/79Ple7DMw6ojgUm3sY/ykurhqdhlY=;
        b=rab1mS3Gf8pt5jsRjfKhfTlyyF4vHUtNvVPzOAYxxxoaBBN2BRxfYActfILWvTPlan
         N1wEpdttWaChkVl4oLut9FH0eCKmAE47Bv9v6R/q8URZWfSL0OepqwLFlj+tNTNu0/jw
         JLVhQlUN8KiZx1JiEhbPCDKWKlFaRjJN2M4YM/BzAnHT8DjOouViw0WJmhvTqAItCHUk
         2wISWr4H+gVuQ2xgVbFrTiYsv/oqwpdgYWeoizDlBWat0Es/Yw/RPwQoUR6KxDMXFrlO
         hIDJ6Si3WcRkh07hXieERf9FBHr1tY/cl2nww20pNebsmp4Q5T/aZKio9OKIQR+fSSR4
         gpVw==
X-Gm-Message-State: AHQUAuZT98p2j7M0Ld+F7AwOcYvRKInAKXRbVWEaUtYah9TNDXaVGQja
        wOPzmp8vS0nvQXmLOyTUNYIYRw==
X-Google-Smtp-Source: AHgI3IbbjExxIVMZ/Q5l2fJqGgYlLyNXqRIjZy1X99+QL6qxCmT/iNdNNAwzD5VzBwWJTH5KpeP1EA==
X-Received: by 2002:a50:9938:: with SMTP id k53mr18294957edb.134.1551177239766;
        Tue, 26 Feb 2019 02:33:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id m32sm3441281edc.17.2019.02.26.02.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 02:33:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 91203183BB9; Tue, 26 Feb 2019 11:33:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4.20 161/183] mac80211: Change default tx_sk_pacing_shift to 7
In-Reply-To: <20190226100833.GA9320@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org> <20190225195122.158033941@linuxfoundation.org> <87k1hmrhzy.fsf@toke.dk> <20190226100833.GA9320@kroah.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Feb 2019 11:33:58 +0100
Message-ID: <87h8cqrg89.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 26, 2019 at 10:55:45AM +0100, Toke Høiland-Jørgensen wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > 4.20-stable review patch.  If anyone has any objections, please let me
>> > know.
>> 
>> LGTM. Any chance of getting this into 4.19 as well? It doesn't apply
>> as-is, but I can send an equivalent patch (where?).
>
> Yes, I didn't apply it to 4.19.y as it did not apply cleanly.  You can
> send a backported version to stable@vger.kernel.org and I will be glad
> to pick it up for the next release after these.

Right, will do, thanks! :)

-Toke
