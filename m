Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9518AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9E320837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjxtXzF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeKBSff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:35:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37647 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:35:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so1271183wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1RQ+C828GifRWw9j9HbE3Ffw7vwiz+j8eaB+v95+Po=;
        b=bjxtXzF3KyR6tKdb5fHHGwW5jtbzShT9grr8REoTP0BEBoFGm2uol/Za91/2S6KAfl
         UeYXkdOXpFmt+XyhpHxWHOPtu7YrxREXO29i0GxNBq8p/XxjLLz2V5A/6pVVE14onp6I
         vpPh5PyEAk7SG4aN21npDWv9/kWRJAWATpoiWX2Xd0zIo4oLWUzEAYt8x/sY4Z2toRpJ
         iJa7wtSNzGtkkXIp7Dzypg2F2jEl0hBGV0vG9bePSSkXzDIKNrac8EeqY6THPjWNxjwC
         Rzwd4eflhfi8HiUV1fAGl+LDHXzywNXZilscPWIHUm7yox3yerLpnPrrUawL3JgbN9vd
         bJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1RQ+C828GifRWw9j9HbE3Ffw7vwiz+j8eaB+v95+Po=;
        b=b84ZwuFFcg3An0gvB1CDtM2gfo0ZDWMqzwU5poecLPv3HGPzi2LqqYegEZAiL3vKtf
         ri3PUTpSoBcY9N70JMzO2JmB6Ounb0d+uWWyk2mGerMEniMk/Lqp/UzhOdP89q1KvYPX
         DtS5+/hu2G7fVVQZETXEF2/XLDWiWUkaJr71JyWyknjGj4+vIBumBhsGusmfDY0fVbsw
         GVTAvmmLVXFR8Bdc0luBOXmsHFYDqmcCP7TDIVHcPjfzdEeSKw4HGHOqJsY0ZBzFFSop
         jEJi5MXoY38+0R+BxLggLJYl7zGB+Kga3RtCwFkVmGR/xIKn2Dw3AkloE25DrccP73rR
         ZEHA==
X-Gm-Message-State: AGRZ1gKblMGd4unFgt2pQPszpZL0K/yytFNlmn8ctRraU0Y/smmCXE0U
        HEXl17J22bUVD6w4D4/jQiXpmWjTBwTqkowgDoo=
X-Google-Smtp-Source: AJdET5e+SXHn4iM/+lFJUwm6I21vDf12WT5BKIDFR/djJZjzm4BRRh6leVi0HEEdnhd7pUc/0FLIcfKcBFHQWiZZ1Vk=
X-Received: by 2002:adf:8304:: with SMTP id 4-v6mr9390079wrd.285.1541150941859;
 Fri, 02 Nov 2018 02:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181101225603.17806-1-nkela@cisco.com> <c6b51706910048b8dd0732f8963a69867542e9a4.camel@infinera.com>
In-Reply-To: <c6b51706910048b8dd0732f8963a69867542e9a4.camel@infinera.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 2 Nov 2018 10:28:49 +0100
Message-ID: <CAFLxGvwy=ksb=GVg-D6cD40JQ1b7+RGjXH9vq8w4jB0N9rmK3Q@mail.gmail.com>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     nkela@cisco.com, David Woodhouse <dwmw2@infradead.org>,
        xe-linux-external@cisco.com,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, rod@whitby.id.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 9:46 AM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Thu, 2018-11-01 at 15:56 -0700, Nikunj Kela wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> >
> >
> > This patch allows the endianness of the JFSS2 filesystem to be
> > specified by config options.
> >
> > It defaults to native-endian (the previously hard-coded option).
> >
> > Some architectures benefit from having a single known endianness
> > of JFFS2 filesystem (for data, not executables) independent of the
> > endianness of the processor (ARM processors can be switched to either
> > endianness at run-time).
>
> I like this too. I have on several occasions needed to mount a JFFS2 BE on
> my PC. This saves me from having to hack the src.

The feature makes sense, but I don't like it being a Kconfig option.
As Al pointed out, it should be done like UFS does.

IOW, implement a wrapper function which selects the endianness automatically.
That way you can force it as mount option or detect during mount what
kind of JFFS2
you have.

-- 
Thanks,
//richard
