Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245235-2-4593669086970598202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245234; b=uvLGr9jMDdswqFJtI9QfaojI5EcCNElWnhahpAfkf3PlIaqTpb
    v6IcTw78X/yb8pXkv6bNDEerStVDLZHUGsYqqHHcN0h98EZNMLjuzICgY8T3dKX4
    W1l0a/PvayZFZuxg9dTMUs1Ihq5zP15p2JG98MFUXLDi8GGPyH02zDZZhV+HTWvT
    FnK5WfUvkTx2t26IAHTxw0kUQv52anMyep75zZcTsAnQH7etGGCr0xJGNekByajb
    4NnpO1TDQdvzlvQskC8gm+AW2RbiKC1XYBcGEP0BWE6PsdORZCVNGDLtCsAQMmIg
    8QVNM0XS36nnpPv2MOYq2lcuiJar7SgVQb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523245234; bh=BrTlr//0h1pdvdO4ZFBLapNcfqGpK9
    UD2TIyAaR/Ebo=; b=CJB6e5JAeFZni3jjd+fyi5PCTVUhauh/hcDX9CYwW5wojS
    UDsLW9ftWbORjbOJuDt7IQ6pugDMAsdA4GJ6yNty0UWsj4hojsl5rI2R7yZhpHVy
    Wk+0h9UwtnDm3aAwbvEwGBhMglh0fRxmNlyNSw+wnAii/JNOGFAJzq0XIU1+NR+j
    ueSQ56WknZbFIRPrXHQFAlX6lYzaHquMgE3w5iVbO99uHIQILvVSRJ4gzYZb8GWI
    4GBC8AyjbHtf98fmtPDlYb1izP9VZWou9V9S4R3Njv0FYkPdQ2/ELMRT2/oN0Rbt
    Y7B4hl9BkQxcLsUIfin1JHrnmlKul+rlLgJHC4Mw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gEXWU5c4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f+7Vv2VJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gEXWU5c4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f+7Vv2VJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOmC1NQSS1CRsSfE0P5QSCL3PXUrUgWztS8o9ofp4f2wdViVXloZBuOmOVyTheWXlOHBqHj5wMcLYAK3fFXHLtDLBENRfDymJmRS1U8b/Y7MYtx77QoZ
    44AqN4SS35qvObGcY9P6uY33VOxZK37PZJIBjU2vdwOHarzJI9pZlMTaCQElixTn48qIkSFutjDyr6sxdhS0LvbMD8tSaQAvzIQB6e7MV9mxlPTEbS6W+Njn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=RXHMGUnP3f0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=7RQkSx1-yMdvnn_fdoAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754421AbeDIDkR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:40:17 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:46098 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbeDIDkN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 8 Apr 2018 23:40:13 -0400
X-Google-Smtp-Source: AIpwx4+4Gr7u4W0JLop4sD3HBCLWsVSwkQ0BY2rOqPfvM3Sy9MahFdSOM+E880hJME4gbOO+dXm+cA==
Date: Sun, 8 Apr 2018 20:40:10 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: joeyli <jlee@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
 <20180408080742.GE7362@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408080742.GE7362@linux-l9pv.suse>
User-Agent: NeoMutt/20180223
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 04:07:42PM +0800, joeyli wrote:
> 
> > If the only thing that folks are paranoid about is reading
> > arbitrary kernel memory with bpf_probe_read() helper
> > then preferred patch would be to disable it during verification
> > when in lockdown mode
> 
> Sorry for I didn't fully understand your idea...
> Do you mean that using bpf verifier to filter out bpf program that
> uses bpf_probe_read()?

Take a look bpf_get_trace_printk_proto().
Similarly we can add bpf_get_probe_read_proto() that
will return NULL if lockdown is on.
Then programs with bpf_probe_read() will be rejected by the verifier.

