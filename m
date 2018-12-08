Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBAC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1D2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC2wQhKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLIA7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 19:59:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33335 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIA7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 19:59:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so7313493otl.0;
        Sat, 08 Dec 2018 16:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6hyBNtXtk8QJd/0fN3k0sl9h5vNd3JJTGW7U7PZofg=;
        b=rC2wQhKhX2jfyjTw3+QqcInBvttzcz2wW1M5FIRRk7WrtlrzZCKNHkEBHo2N1xPJDv
         yZapSEK2DnrrFW6ptlNUi4FN1wmxFUphty1MKVZfsPndgUHSX+GYClK1yGNC0iOdsJDo
         2L4jxAGEjHrtgBEL+6PWiNDduQ4rz3n86fVqYaC4xf5cqistHvKGcDCGKXcnRa24iYVk
         OpH3E+pOHP1jlYefaLY4PG/011KehEnzoxM3aq7yNtgPeit0kYTvkKELCugejh/2OIQr
         kuBSJeB8NgvRYuMOBH5MRNixvwwLCS1TFlDWHFkLmGaG86iiLlZODTbyUMSOxwLrKArD
         RZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6hyBNtXtk8QJd/0fN3k0sl9h5vNd3JJTGW7U7PZofg=;
        b=fuwd5XNCa0MlFFBLXAdtO21MPH5hwHOnekU4Jz1H3awtySj2zyH39pl+EoCMaJe+g1
         N3lEZzkvFMyc6C2G2szICtnZ+3PbfVSljbW/FyGk6kCJE2Ib6faPONPXn15IkyykF9Pi
         EALLwA956BUo+vVxmcFvIQ9XNZmWZT6HMz9IcFWX7w4VDsT+za1RmNsEWp37EEFotCIz
         3x+w/oj+fQx19d7sZMbR5kpRU+QPdzb+etkerO+T5z1IXhAb5p+HVzXDuMSWAOXyE/00
         Ykportr6rWAjJw00iaIhfT8AnSW/VnXWUq7EHLlRcffa1IripndgmV02elS9cfYMXUVR
         YgCA==
X-Gm-Message-State: AA+aEWb/NPzhTUHZpDv91E4oYGomsufe111Fy9RgFWMM7oyu241wK9OU
        GLYfL/5naHljVZ7DHAiItCBHKtmccTdgwYvQheo=
X-Google-Smtp-Source: AFSGD/Vp6jlEQ/nvdrcc7+MeHkCadzJxm3qfwP3C0aTgWzXuy9VTEip6b6h2+aJxZ+PfXAxQQGwsaGi2UDpHIPk4sC4=
X-Received: by 2002:a05:6830:13d7:: with SMTP id e23mr5259029otq.2.1544317161194;
 Sat, 08 Dec 2018 16:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20181202093257.3918-1-geert@linux-m68k.org> <20181203110506.GA7485@kroah.com>
 <20181203121519.GA7478@amd> <CAHk-=wiDeCY_ENy9S-6DjPgzzF=1UucJGrKo_K98jYA-yR1jJg@mail.gmail.com>
In-Reply-To: <CAHk-=wiDeCY_ENy9S-6DjPgzzF=1UucJGrKo_K98jYA-yR1jJg@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Sat, 8 Dec 2018 20:31:53 +0000
Message-ID: <CAMkWEXP3BQJ-UAVOcMEo+9gJevPJG8Ahor0MFydiGG8-=xOUUg@mail.gmail.com>
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
To:     torvalds@linux-foundation.org
Cc:     pavel@ucw.cz, gregkh@linuxfoundation.org, geert@linux-m68k.org,
        corbet@lwn.net, frowand.list@gmail.com, tomi.valkeinen@iki.fi,
        bvanassche@acm.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:52 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 3, 2018 at 4:15 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Linus, I don't think Greg is doing good job maintaining this. Can you
> > take the patch?
> > (Or explain what is going on here, because I don't
> > think public has full story).
>
> I think Greg is doing a fine job, and I personally will not take
> patches to the CoC without *much* stronger reasons than just some
> random opinion.
>

Oh wow, see this is why I was 50/50 split on if I should still spend my
time working on Linux anymore, glad that's now settled.

I think Greg is doing a fine job dodging questions by saying, "it's
fine, just wait and see if something happens". Who are the $(people)
that choose to put this document into the kernel repo, and most
importantly, WHY? Was it You, Greg, Someone else too? What opinions
lead $(people) to choose the exact wording in this document, are
they not also "random" opinions on a non-technical issue that should
be equally disregarded?

> This is an area where everybody has opinions, and there is no inherent
> technical agreement ...
> ... actual problems caused by real
> issues ...
>

What a nice *professional* reply, you wear your best suit and tie
for sending emails now? We have reached canary status, IM{NR,R}O.
Not that you people care, but FWIW: I'm officially done with upstream
Linux as a bare metal kernel. I won't criticize any awkward patches
people are proposing, or propose any of my own because I've lost
trust in upstream to manage and defend the project adequately from
it's competitors so this is all starting to feel like a waste of
my free time now.

OK, I can't leave you all without letting you the one thing that angered
me nearly every time I updated to a new "stable" kernel over the last 3-4
years. The phrase "we don't break userspace" is misleading at best, unless
you assume all userspaces are running up to date .so's published by the
kernel maintainers. All of my code interfaces directly with the kernel and
not some .so layer that hides API breakage from it's users. Though my opinion
is just some random and absolutely not professional or corporate sponsored
opinion and thus in this newest age of Linux development, must be worthless!

Linux kernel dev's should now have to repeat this mantra "there is no
breakage, your userland just needs updates!" (obviously /s). I was actually
getting nervous about having to update from 4.14 soon and learning about the
fun new undocumented behaviors (sadly not /s).

Sorry if this wording is too harsh, I mean no disrespect just genuinely
DONE with this corporate bullhug[1] AND false sense of stability. AND the
fact that you feel there are no real problems caused by horribly worded
governance related documents with glaringly obvious and probably exploitable
flaws. A document that AFAICT nobody likes except You, Greg, and a few people
getting their paycheck from $(multi-billion-dollar corporation with
questionable motives and history).

[1]: In order to comply with the CoC, replace **** with a hug.

---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c        | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index 9cc10e438b3d..55a0060881ea 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
 {
        /* This appears to be the behaviour of the VBIOS parser, and *is*
         * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
-        * avoid fucking up the memory controller (somehow) by reading it
+        * avoid hugging up the memory controller (somehow) by reading it
         * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
         *
         * Preserving the non-caching behaviour on earlier chipsets just
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
index 3737bd27f74e..ee364c71cc2e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
@@ -46,7 +46,7 @@
 #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
 #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
 #define NV_PPWR_INTR_EN_CLR                                              0x0014
-#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
+#define NV_PPWR_INTR_EN_CLR_MASK                    /* hug i hate envyas */ -1
 #define NV_PPWR_INTR_ROUTE                                               0x001c
 #define NV_PPWR_TIMER_LOW                                                0x002c
 #define NV_PPWR_WATCHDOG_TIME                                            0x0034
