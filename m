Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F5720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oz+VWzus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F5720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeIRWB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:01:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45832 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRWB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:01:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so2421870eda.12;
        Tue, 18 Sep 2018 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIA8zOCECTcKows+uTc5YbM8xE143Bi/O52cX3iDyNE=;
        b=oz+VWzusYi8UAUgSVCOwiDoyCEwUN0nvLpJHuGhmZR8kTv/r4i00ry9TKuFrHQ4O3g
         K2ClUs8l9MkiCxwiTCx9iaUGfybEmvMIys81oZW7aXqgxRv1kWVbzxu9eAEN9M1lIP3U
         oN/Jd6mHZQdNHuvlY2Qy/3TF2pFo1cFXDpToFe/DFaIdcU/soob/P4bGP1myurV53XiA
         ZLCZSgbZ0rns8roAaE1nIdvz+dXslYg3cHIQASamRFdvo0naPxKHXWW5hQKn0mvhRzWB
         OyYR4TL2YT/J3nVhuTboXq10S8Yb8KgCq5uAA+1bvdnSwQdVT4Sx1d8fim4J6TOx2I47
         oMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIA8zOCECTcKows+uTc5YbM8xE143Bi/O52cX3iDyNE=;
        b=nume5z7FhTI/7AgTpKMpPPqUH9P+jPT7C0xDFTzwoSYwjTt+M/V7wBK4+DC2qI1yOB
         QWIl0YbQBIFZg47CX+hVwPmgWgyjPxyhcNoPGzYtYPa3H3/yEGkBfy8EoxpP59DspP+I
         7H6moN+um1HC8gLp3VqEJJsWivVRLXAA6DrVj9X8ud362vIL+OhczsldcSlDDzLzrXHa
         i2i5GPCAJzFazYj79jwTm/+5tCh3q1rpWVxhV94ARksC4fX3Rsd1dJuh2fPMoxkrloiC
         Zw6f02IRDqb4kiE4q9pL0oYXTBKy+zNGE77USFNPMCaEkTxeSPZOs3XUtpJMKGp6fQTX
         5Tnw==
X-Gm-Message-State: APzg51AOqv4j5cvF1AVoxgPrw5/zo+1k5fSmdKQ7wLWNNShG84LkUAu/
        roEupxFiqiNhUMxZPMOqJBEPLd+l335YJCG3zvc=
X-Google-Smtp-Source: ANB0VdZBx2+0BRU9q7OrIol1tipNauIGabRJEWxzeOXUPydO7Pi8iK5IaUqx4HsoqCdE4OM5As9qdmHerEIJe1LsqZo=
X-Received: by 2002:a50:fa0a:: with SMTP id b10-v6mr2397687edq.138.1537288114083;
 Tue, 18 Sep 2018 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180918151235.4284275f@canb.auug.org.au> <0dc91212-54e8-d2f0-a4e3-30a468c20b8d@infradead.org>
 <a1129d67-97e3-8f10-c938-0de72fee9377@iogearbox.net>
In-Reply-To: <a1129d67-97e3-8f10-c938-0de72fee9377@iogearbox.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Sep 2018 12:28:04 -0400
Message-ID: <CAF=yD-Kv7ig9UEo8Ci3eZOV=spa9cbGA5Mfa5Too8TgUzVA3fA@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 18 (kernel/bpf/syscall)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     rdunlap@infradead.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:44 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> [ Cc Petar and Willem ]
>
> On 09/18/2018 05:37 PM, Randy Dunlap wrote:
> > On 9/17/18 10:12 PM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20180913:
> >
> > on i386 or x86_64: (in 6 of 20 randconfigs)
> >
> > kernel/bpf/syscall.o: In function `__x64_sys_bpf':
> > syscall.c:(.text+0x3278): undefined reference to `skb_flow_dissector_bpf_prog_attach'
> > syscall.c:(.text+0x3310): undefined reference to `skb_flow_dissector_bpf_prog_detach'
> > kernel/bpf/syscall.o:(.rodata+0x3f0): undefined reference to `flow_dissector_prog_ops'
> > kernel/bpf/verifier.o:(.rodata+0x250): undefined reference to `flow_dissector_verifier_ops'
> >
> > Full randconfig file is attached.
>
> Looks like we need a wrapper for these, config had:
>
> # CONFIG_NET is not set

Thanks for forwarding the report.

For the functions, I think we can use a similar static inline stub as
used e.g., for bpf_map_offload_map_alloc.

The _ops references are from a macro that includes linux/bpf_types.h,
so indeed a CONFIG looks needed.

I need to look it over before I send out, but tentative patch:

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 22083712dd18..f57fa5a6be8f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -32,7 +32,9 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
 #ifdef CONFIG_INET
 BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport)
 #endif
+#ifdef CONFIG_NET
 BPF_PROG_TYPE(BPF_PROG_TYPE_FLOW_DISSECTOR, flow_dissector)
+#endif

 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ce0e863f02a2..d26a21f10cec 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1194,10 +1194,23 @@ void skb_flow_dissector_init(struct
flow_dissector *flow_dissector,
                             const struct flow_dissector_key *key,
                             unsigned int key_count);

+#if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
 int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
                                       struct bpf_prog *prog);

 int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr);
+#else
+static inline int skb_flow_dissector_bpf_prog_attach(const union
bpf_attr *attr,
+                                                    struct bpf_prog *prog)
+{
+       return -EOPNOTSUPP;
+}
+
+static inline int skb_flow_dissector_bpf_prog_detach(const union
bpf_attr *attr)
+{
+       return -EOPNOTSUPP;
+}
+#endif
