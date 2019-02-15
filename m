Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F23DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D8A21917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBJsiwhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbfBOHwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:52:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37980 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfBOHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:52:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so8596156wmh.3;
        Thu, 14 Feb 2019 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tp9dCTQxksO246/bg8Clezg+jkh0IFjsiwXgqzdeyzs=;
        b=gBJsiwhFLp083iwATpNTvNjERoh3f5a/Gp1s+1n50lYT/UY1YOihcMRfukMsuqpEbD
         vUkV4FS+PtdEvH0ocmVqc49WHVNz3WDrFW+U0WmjL0/faq7RS1ExKyhASvCS4/JRRePP
         ocu8jc9qeHO4PYqO5jYEA7csuwYtb7ZKqgBWSDI6jR+f6OJ9Vg7SFMLKbXYU1ereyNAl
         S6NnckMCvwLVrfcfd78zzRaQnp7/NicPhuRkSSiQimgy4jlOzpLDZtRSIZG3qoK/bXeO
         ZQNOSuX1AcR2P19r+hH1+KyIo3Ji/Z20y4edUz5CRFLr1Xzyz9HewTYJI+q36HdzN0su
         ccUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tp9dCTQxksO246/bg8Clezg+jkh0IFjsiwXgqzdeyzs=;
        b=tJHS5te+Q51902OO+U6MxRaODXJUB+Zqgz+vzVpOmF/WxCMv1qbPt4+zVSyKgxOGhu
         9KVFvnmPoaxNqZyIBp7jYmk9xnWqTfRk2esz7vIctwjfxOSdN0h7NYrmoZytSWJdA76d
         MbVqClHALGTA7DQt4JvciMq9mnEazJp7M0XUy6Zs0QI1cvEFfyfzXysqUt28yiShr6kB
         obk/n+Fqx5gPK0q05v/a+6efeqscNNwbfrGidRcPumrAJxTDgGRU3ibnak65pBKZ6fYM
         HFEFIPIs63+lIVYv1si0t3RiE7IJGxIjL5w3eL8psZMbWF+tzWT4PHop6ogXKAa08ZJo
         mrBw==
X-Gm-Message-State: AHQUAuauIPJn5e3smXxTjMm7JSXg+UGbXu6N31Ymbqyb62hHSk291weG
        ng1mGoGTexEZboZUnfEiPjgsBbiiku1B6A4r448=
X-Google-Smtp-Source: AHgI3Ia3t2Zh3Q/Fe7eC9lkrK0jID6T04kKER+Y+BRKdmB49WJtlgOXbu3cMoPxtPljISKH4aGNeUk3OJvqL6qF/Dus=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr5378698wmb.85.1550217153117;
 Thu, 14 Feb 2019 23:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20190211170751.1687-1-sedat.dilek@credativ.de>
 <20190211175306.GA16698@archlinux-ryzen> <CA+icZUXjyWkVYoW7HwXTXm5wz1E0KJWhH9uiwGJeODUFzB0DJQ@mail.gmail.com>
 <20190212224242.GA29735@archlinux-ryzen> <0a37de95-a440-12a7-d99d-72d815f0b56f@suse.de>
In-Reply-To: <0a37de95-a440-12a7-d99d-72d815f0b56f@suse.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Feb 2019 08:52:21 +0100
Message-ID: <CA+icZUWS7t0CmPAw5wQk7o2f5K68DOcVbMTOOpk77XxB8ed6=w@mail.gmail.com>
Subject: Re: [PATCH RFC v2] fcoe: make use of fip_mode enum complete
To:     Hannes Reinecke <hare@suse.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@credativ.de>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        QLogic-Storage-Upstream@cavium.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 8:35 AM Hannes Reinecke <hare@suse.de> wrote:
>
> On 2/12/19 11:42 PM, Nathan Chancellor wrote:
> > On Tue, Feb 12, 2019 at 08:50:04AM +0100, Sedat Dilek wrote:
> >> On Mon, Feb 11, 2019 at 6:53 PM Nathan Chancellor
> >> <natechancellor@gmail.com> wrote:
> >>>
> >>> On Mon, Feb 11, 2019 at 06:07:51PM +0100, Sedat Dilek wrote:
> >>>> From: Sedat Dilek <sedat.dilek@gmail.com>
> >>>>
> >>>> commit 1917d42d14b7 ("fcoe: use enum for fip_mode") introduces a separate
> >>>> enum for the fip_mode that shall be used during initialisation handling
> >>>> until it is passed to fcoe_ctrl_link_up to set the initial fip_state.
> >>>> That change was incomplete and gcc quietly converted in various places
> >>>> between the fip_mode and the fip_state enum values with implicit enum
> >>>> conversions, which fortunately cannot cause any issues in the actual
> >>>> code's execution.
> >>>>
> >>>> clang however warns about these implicit enum conversions in the scsi
> >>>> drivers. This commit consolidates the use of the two enums, guided by
> >>>> clang's enum-conversion warnings.
> >>>>
> >>>> This commit now completes the use of the fip_mode:
> >>>> It expects and uses fip_mode in {bnx2fc,fcoe}_interface_create and
> >>>> fcoe_ctlr_init, and it explicitly converts from fip_mode to fip_state
> >>>> only at the single point in fcoe_ctlr_link_up.
> >>>>
> >>>> To eliminate that adding or removing values from fip_mode or fip_state enum
> >>>> break the right mapping of values, all fip_mode values are assigned to
> >>>> their fip_state counterparts.
> >>>>
> >>>> Link: https://github.com/ClangBuiltLinux/linux/issues/151
> >>>> Fixes: 1917d42d14b7 ("fcoe: use enum for fip_mode")
> >>>> Reported-by: Dmitry Golovin "Twisted Pair in my Hair" <dima@golovin.in>
> >>>> CC: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >>>> CC: Nick Desaulniers <ndesaulniers@google.com>
> >>>> CC: Nathan Chancellor <natechancellor@gmail.com>
> >>>> CC: Hannes Reinecke <hare@suse.com>
> >>>> Suggested-by: Johannes Thumshirn <jthumshirn@suse.de>
> >>>> ---
> >>>>
> >>>> [ v2:
> >>>>     - Based on the original patch by Lukas Bulwahn
> >>>>     - Suggestion by Johannes T. [1] required some changes:
> >>>>       + s/case FIP_ST_VMMP_START/case FIP_ST_V*N*MP_START
> >>>>       + s/return FIP_ST_AUTO/return FIP_MODE_AUTO
> >>>>     - Add Link to ClangBuiltLinux issue #151
> >>>>     - S-o-b line later when there is an OK from the FCoE maintainers
> >>>>
> >>>> NOTE: Compile-tested against Linux-v5.0-rc6 with LLVM/Clang from Git with
> >>>>        experimental asm-goto support via executing:
> >>>>        $ make V=1 CC=clang-9 HOSTCC=clang-9 drivers/scsi/fcoe/
> >>>>
> >>>> [1] https://marc.info/?l=linux-scsi&m=154745527612152&w=2
> >>>>
> >>>>    -dileks ]
> >>>>
> >>>>   drivers/scsi/bnx2fc/bnx2fc_fcoe.c  |  2 +-
> >>>>   drivers/scsi/fcoe/fcoe.c           |  2 +-
> >>>>   drivers/scsi/fcoe/fcoe_ctlr.c      |  4 ++--
> >>>>   drivers/scsi/fcoe/fcoe_transport.c |  2 +-
> >>>>   drivers/scsi/qedf/qedf_main.c      |  2 +-
> >>>>   include/scsi/libfcoe.h             | 22 ++++++++++++++++++++--
> >>>>   6 files changed, 26 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> >>>> index 2e4e7159ebf9..a75e74ad1698 100644
> >>>> --- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> >>>> +++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
> >>>> @@ -1438,7 +1438,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cnic_dev *cnic)
> >>>>   static struct bnx2fc_interface *
> >>>>   bnx2fc_interface_create(struct bnx2fc_hba *hba,
> >>>>                        struct net_device *netdev,
> >>>> -                     enum fip_state fip_mode)
> >>>> +                     enum fip_mode fip_mode)
> >>>>   {
> >>>>        struct fcoe_ctlr_device *ctlr_dev;
> >>>>        struct bnx2fc_interface *interface;
> >>>> diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
> >>>> index cd19be3f3405..8ba8862d3292 100644
> >>>> --- a/drivers/scsi/fcoe/fcoe.c
> >>>> +++ b/drivers/scsi/fcoe/fcoe.c
> >>>> @@ -389,7 +389,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
> >>>>    * Returns: pointer to a struct fcoe_interface or NULL on error
> >>>>    */
> >>>>   static struct fcoe_interface *fcoe_interface_create(struct net_device *netdev,
> >>>> -                                                 enum fip_state fip_mode)
> >>>> +                                                 enum fip_mode fip_mode)
> >>>>   {
> >>>>        struct fcoe_ctlr_device *ctlr_dev;
> >>>>        struct fcoe_ctlr *ctlr;
> >>>> diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
> >>>> index 54da3166da8d..a52d3ad94876 100644
> >>>> --- a/drivers/scsi/fcoe/fcoe_ctlr.c
> >>>> +++ b/drivers/scsi/fcoe/fcoe_ctlr.c
> >>>> @@ -147,7 +147,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
> >>>>    * fcoe_ctlr_init() - Initialize the FCoE Controller instance
> >>>>    * @fip: The FCoE controller to initialize
> >>>>    */
> >>>> -void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_state mode)
> >>>> +void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
> >>>>   {
> >>>>        fcoe_ctlr_set_state(fip, FIP_ST_LINK_WAIT);
> >>>>        fip->mode = mode;
> >>>> @@ -454,7 +454,7 @@ void fcoe_ctlr_link_up(struct fcoe_ctlr *fip)
> >>>>                mutex_unlock(&fip->ctlr_mutex);
> >>>>                fc_linkup(fip->lp);
> >>>>        } else if (fip->state == FIP_ST_LINK_WAIT) {
> >>>> -             fcoe_ctlr_set_state(fip, fip->mode);
> >>>> +             fcoe_ctlr_set_state(fip, (enum fip_state) fip->mode);
> >>>>                switch (fip->mode) {
> >>>>                default:
> >>>>                        LIBFCOE_FIP_DBG(fip, "invalid mode %d\n", fip->mode);
>
> Watch out for this one.
> fip_mode != fip_state.
>
> This arguably is an error even now; it might _just_ work if we have
> fip->mode == FIP_MODE_FABRIC, but we probably will be getting
> interesting results when fip->mode == FIP_MODE_VN2VN ...
>
> We should rather call
>
> fcoe_ctrl_set_state(fip, FIP_ST_AUTO)
>
> here and update it to NON_FIP in the switch statement itself.
> But I'll have to think about it some more to figure out what would
> happen for VN2VN mode.
>
> Will be sending an updated patch.
>
> Cheers,
>
> Hannes

Thanks Hannes for taking care.

Regards,
- Sedat -
