Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D81214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dds.mil header.i=@dds.mil header.b="EMuRXmOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D81214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dds.mil
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeHOUzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:55:50 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43980 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeHOUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:55:50 -0400
Received: by mail-ed1-f46.google.com with SMTP id j21-v6so1249552edp.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dds.mil; s=ddsmail;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OK+fN5Jwv2zapwHHX+l7brYZgUxVffnU2PnnqnoQAFk=;
        b=EMuRXmOyVc5EqDqo0LbY3HCnNnheMsIdLVKUIgtnN5lNMWzx2hCp7g37v9FduYrxvZ
         XTv7HajV4tdMCp7AfjHysqfhHfELxI7Yi0G1P5p7kLAVuH87KJOlPI2qCfTs7opl7WOk
         S0GRX3pDy/+Px+WQpBJTaSQgv77OeF/oOcW/BWl2tiABIaw1Zt+VYj38dRccqvciphdP
         UGYLD3EZQ1KIxL1xCAV7vzOT/o6NHBmnyceh1Tl2tCJVZEaptbsJllAeLTdLqFqKcPDN
         2DzIVURW3okUC+Q49u/Kei2r7cOeQ1Ac0LV3ScqmQOdT3Ec4+8Yhp5GFBy8nCCwVd4Ap
         OfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OK+fN5Jwv2zapwHHX+l7brYZgUxVffnU2PnnqnoQAFk=;
        b=LG3uKI72fmomy/n9Z4KQ426iOlAeSf0uqBU6Wc1iQgFul5aSV4bq+DCzqM2yq7zts2
         D+cx6vvxGl/5QFhkNW5ninBBAuh0D6FatE8EzLqV9MG7GvgJlp+DV731nE79/iyPMdyH
         +KGK3oTU3MqypuI+u0y1VH+HSIOY4iiD0iZnfGRFHm5UrxLbKEbi9B+XY2ly1tVRKLWU
         4AGwE+UgPMSG8ToZxxadkMz3evSHpx6lDTLgKJSwg7ly9mdDcD7iiSzCffiVtC5qwShD
         bLEKUz2IiPwWYjC172IHtCDSZ1w6R38qt5HN+RNeFSF8eyra4+dBD2WDPFN64VWy9OsF
         L3fQ==
X-Gm-Message-State: AOUpUlFDkHZ44TioPwO/amiRRgMe9imsUeVuo34zT7kuAD0QuYtpjg9q
        ytGS1xd/xh+r39ha1zvs6sqg5aEwBLjETKqbw7jJVw==
X-Google-Smtp-Source: AA+uWPztQpr+BF+r9odsl6NJWA+rlLng7ckktXj6m6AQm/biIkOGaSVeo9t4dofDI9n9RjyZ3oyU576Yk9QVFmPQ87Y=
X-Received: by 2002:a50:f577:: with SMTP id w52-v6mr33569376edm.230.1534356158784;
 Wed, 15 Aug 2018 11:02:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:aed3:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 11:02:08
 -0700 (PDT)
In-Reply-To: <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com> <20180810214433.GA15044@linux.intel.com>
 <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com> <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
From:   Harlan Lieberman-Berg <harlan@dds.mil>
Date:   Wed, 15 Aug 2018 14:02:08 -0400
Message-ID: <CAO-sURTJVjscq2uvM0AYxbNuj2LyTypHYK+yAOCB_x-1y-YzMw@mail.gmail.com>
Subject: Re: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
To:     Tomas Winkler <tomasw@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Just wanted to give you a quick update now that I got my hands on an
OEM Windows version of the same machine.  I can confirm that Windows
is able to use the TPM to some extent; confirmation and some of the
output of some of the TPM Powershell cmdlets is at
https://gist.github.com/hlieberman-gov/915fda005e3297570e9e6e68e1708bc6

Sincerely,

-- 
Harlan Lieberman-Berg
Defense Digital Service
