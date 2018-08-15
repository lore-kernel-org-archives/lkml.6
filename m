Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888DE2154F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu63Mu3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888DE2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHOX4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbeHOX4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:56:44 -0400
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D5C21557;
        Wed, 15 Aug 2018 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534366974;
        bh=1+mqcd8Oxra6H3t9KBPou6pJ91NhJ3nh+BB8V7aRh1I=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=hu63Mu3pUk1u77QEZ00pEe+Ekd/QGQiY955YXJakjtDexb0rbEHBrYDVf0pKKQp9W
         Dvpcx+jfvrW0CwYmlokFudI6X989eHr4tQx9DKOrDQBWGCNclHYmMclUBZ9g/b1AZC
         7nmuCh0FVfE+MK52sitYaNriE1JXQbT8JT100ZDA=
Received: by mail-yw1-f42.google.com with SMTP id r184-v6so1882980ywg.6;
        Wed, 15 Aug 2018 14:02:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlF2VbjzM1fU+THdQbeU+2nXkLq/wF+zKwhWMK01KxgTpHOB8FWL
        Sl0LeCxiYWv7aPO6VcgH+q9h+GyNTD/hWuqvvOs=
X-Google-Smtp-Source: AA+uWPxFsjbMjzbBxIwxIm0eJe3TXZfKhaR+8L0K8FJqMmxFf24jnBrOjiTQ3fV2m0QqpRE6kwe7HCV+bJMj7EGWclo=
X-Received: by 2002:a25:d657:: with SMTP id n84-v6mr1731075ybg.62.1534366972515;
 Wed, 15 Aug 2018 14:02:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81cc:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 14:02:12
 -0700 (PDT)
In-Reply-To: <2076282.DFHNtXLtgF@harkonnen>
References: <4617134.5euanDEBgJ@pcbe13614> <2419388.jt6midSiEu@pcbe13614>
 <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com> <2076282.DFHNtXLtgF@harkonnen>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 15 Aug 2018 16:02:12 -0500
X-Gmail-Original-Message-ID: <CANk1AXTWZk2bA2ysK+1ZEMGUo5rd8GaVoRi+MH8Fwsxs1H0RYA@mail.gmail.com>
Message-ID: <CANk1AXTWZk2bA2ysK+1ZEMGUo5rd8GaVoRi+MH8Fwsxs1H0RYA@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:47 PM, Federico Vaga <federico.vaga@cern.ch> wrote:
> Hi Alan,
>
> Thanks for your time, comments below
>
> On Wednesday, July 18, 2018 9:47:24 PM CEST Alan Tull wrote:
>> On Thu, Jun 28, 2018 at 2:50 AM, Federico Vaga <federico.vaga@cern.ch>
> wrote:
>> > On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
>> >> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga
>> >
>> > <federico.vaga@cern.ch> wrote:
>> >> > Hi Alan,
>> >> >
>> >> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
>> >> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
>> >> >> <federico.vaga@cern.ch> wrote:
>> >> >>
>> >> >> Hi Federico,
>> >> >>
>> >> >> >> > What is buggy is the function fpga_mgr_get().
>> >> >> >> > That patch has been done to allow multiple FPGA manager
>> >> >> >> > instances
>> >> >> >> > to be linked to the same device (PCI it says). But function
>> >> >> >> > fpga_mgr_get() will return only the first found: what about
>> >> >> >> > the
>> >> >> >> > others?
>>
>> Looking at this further, no code change is needed in the FPGA API to
>> support multiple managers.  A FPGA manager driver is a self-contained
>> platform driver.  The PCI driver for a board that contains multiple
>> FPGAs should create a platform device for each manager and save each
>> of those devs in its pdata.
>>
>> >> >> >> > Then, all load kernel-doc comments says:
>> >> >> >> >
>> >> >> >> > "This code assumes the caller got the mgr pointer from
>> >> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >> >> >> >
>> >> >> >> > but that function does not allow me to get, for instance,
>> >> >> >> > the
>> >> >> >> > second FPGA manager on my card.
>>
>> fpga_mgr_get() will do what you want if your PCI driver creates a
>> platform device per FPGA manager as mentioned above.
>>
>> >> >> >> > Since, thanks to this patch I'm actually the creator of the
>> >> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
>> >> >> >> > to
>> >> >> >> > retrieve that data structure.
>>
>> The creator of the FPGA mgr structure is the low level FPGA manager
>> driver, not the PCIe driver.
>
> In my case it is.
> It's a bit like where SPI driver is the low level FPGA manager driver for
> the xilinx-spi.c. But if I understand what you mean, I should always have a
> platform_driver just for the FPGA manager even if it has a 1:1 relation
> with its carrier? In other words, I write two drivers:
> - one for the FPGA manager
> - one for the PCI device that then register the FPGA manager driver
>
> In my case the FPGA programmed is also the PCIe bridge (GN4124). Probably I
> can do it anyway, because the part dedicated to FPGA programming is quite
> independent from the rest (don't remember all details)
>
>> >> >> >> > Despite this, I believe we still need to increment the
>> >> >> >> > module
>> >> >> >> > reference counter (which is done by fpga_mgr_get()).
>>
>> This is only done in the probe function of a FPGA region driver.
>>
>> >> >> >> > We can fix this function by just replacing the argument from
>> >> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
>> >> >> >>
>> >> >> >> At first thought, that's what I'd want.
>> >> >> >>
>> >> >> >> > Alternatively, we
>> >> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
>> >> >> >> > 'get'
>> >> >> >> > it
>> >> >> >> > when we use it. Or again, just an 'owner' argument in the
>> >> >> >> > create()
>> >> >> >> > function.
>> >> >> >>
>> >> >> >> It seems like we shouldn't have to do that.
>> >> >> >
>> >> >> > Why?
>> >> >>
>> >> >> OK yes, I agree; the kernel has a lot of examples of doing this.
>> >> >>
>> >> >> I'll have to play with it, I'll probably add the owner arg to the
>> >> >> create function, add owner to struct fpga_manager, and save.
>> >> >
>> >> > I have two though about this.
>> >> >
>> >> > 1. file_operation like approach. The onwer is associated to the
>> >> > FPGA manager operation. Whenever the FPGA manager wants to use an
>> >> > operation it get/put the module owner of these operations
>> >> > (because this is what we need to protect). With this the user is
>> >> > not directly involved, read it as less code, less things to care
>> >> > about. And probably there is no need for fpga_manager_get().
>> >>
>> >> How does try_module_get fit into this scheme?  I think this proposal
>> >> #1 is missing the point of what the reference count increment is
>> >> meant to do.  Or am I misunderstanding?  How does that keep the
>> >> module from being unloaded 1/3 way through programming a FPGA?
>> >> IIUC you are saying that the reference count would be incremented
>> >> before doing the manager ops .write_init, then decremented again
>> >> afterwards, incremented before each call to .write, decremented
>> >> afterwards, then the same for .write_complete.
>> >
>> > I'm not saying to do module_get/put just around the mops->XXX(): it's
>> > too much. Just where you have this comment:
>> >
>> > "This code assumes the caller got the mgr pointer from
>> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >
>> > Because, currently, it's here where we do module_get()
>>
>> No it's not.
>
> It is not in the code, but the comment says that we should do it before
> calling fpga_mgr_load()
>
>> fpga_mgr_get() or of_fpga_mgr_get() is called when the region is
>> created such as in of-fpga-region's probe.  That way, as long as the
>> region exists, the manager won't be unloaded.  If someone wants to
>> start unloading modules, they need to unload higher level ones first,
>> so they'll have to unload the region before mgr.
>>
>> > Most mops are invoked within a set of static functions which are
>> > called only by few exported functions. I'm suggesting to do
>> > module_get/put in those exported function at the beginning (get) and
>> > and the end (put) because we know that within these functions, here
>> > and there, we will use mops which are owned by a different module.
>> > We do not want the module owner of the mops to disappear while someone
>> > is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use
>> > most of the mops, so we 'get' the module at the beginning and 'put' it
>> > at the end. The same for fpga_region_program_fpga().
>>
>> If we do it the way you are suggesting, then someone can unload the
>> manager module without unloading the region.  The region code will be
>> in for a nasty surprise when programming is attempted.
>
> Of course, this should be taken into account. I was not suggesting a
> precise implementation, but only the idea to hide get/put. Probably there
> other things as well that I'm not considering (indeed I do not have a
> patch, but just a comment)
>
>> > Like this we do not have to ask users to do fpga_mgr_get()/put().
>>
>> The only user who has to do this is a region's probe function.
>>
>> I'm assuming that only fpga_region is using fpga_mgr_load() and
>> anybody who is creating a region uses fpga_region_program_fpga().
>> That's what I want to encourage anyway.  I should probably move
>> fpga_mgr_load to a private header.
>
> All right, if this is what you want to encourage I do not have anything to
> say because I did exactly what you do not want to encourage :)
>
> For me this change everything because I do not use regions since I do not
> have them. The way the API is exposed to me did not encouraged me to use
> their API. In addition, the documentation guides me directly to the FPGA
> manager.

The documentation says:

"If you are adding a new interface to the FPGA framework, add it on
top of a FPGA region to allow the most reuse of your interface."

https://www.kernel.org/doc/html/latest/driver-api/fpga/intro.html

But the stuff that I submitted yesterday goes back through the docs to
clear out anything that is not clear about this.

>
> To be honest I did not have much time to look at the region code. My
> understanding, after a quick look, is that it works great with device-tree.

It is used by the DFL framework which doesn't use device tree.

> But what if I do not have it? Actually, I cannot use device-tree because of
> environment limitations and Linux version in use. Oops, this implies that I
> back-ported the FPGA manager to an older Linux version? Yes, guilty :)

I separated region code from its device-tree dependencies.  But if you
can't use device-tree, then you end up having to implement some of the
things DT gives you for free.

>
> Anyway, I'm using the API exposed, and if part of the assumptions behind
> this API is that I should use device-tree, then I'm out of scope.
>
> <chatting>
> Just for chatting. One addition I made for the FPGA manager is to support
> dynamic loading of FPGA code using char devices. Something like:
>
>    dd if=binary.bin of=/dev/fpga0
>    cat binary.bin > /dev/fpga0

Since it's not handling the bridge, there's some risk involved.

>
> We do not have device tree, and we do not have binaries in /lib/firmware.
> It's quite handy to quickly load a binary just synthesized, especially for
> debugging purpose.

Like a debugfs?

https://lkml.org/lkml/2018/8/2/125

But for a debugging/developing, I have a debugfs that was a downstream
patchset that I'm cleaning for submission.

> If you are interested I can try to clean it up (at some
> point, probably in autumn), or I can show you the code in private for a
> quick look.
> </chatting>
>
>
>> > <Parenthesis>
>> > fpga_region_program_fpga() does not do (today) fpga_mgr_get() because
>> > it assumes, but it is not enforced, that both fpga_region and fpga_mgr
>> > are child of the same device.
>>
>> fpga_region_program_fpga() doesn't do fpga_mgr_get() becuase
>> fpga_mgr_get() happens when the fpga_region probes.  The assumption I
>> am making is that nobody other than a region is calling
>> fpga_manager_load().  I should create a fpga_private.h and move
>> fpga_manager_load() out of fpga-mgr.h to make that official.
>
> Yes, I agree. If what I'm doing is not supposed to happen I should not be
> allowed to do it :)
>
> <suggestion>
> If you want to encourage people to use regions rather than the manager
> directly, have you though about changing the API and merge in a single
> module fpga-mgr and fpga-region?
>
> Brainstorming. Perhaps, it is possible to have a `struct fpga_region_info`
> and when we register and FPGA manager we use something like:
>
> struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>                                      const struct fpga_manager_ops *mops,
>                      struct fpga_region_info *info, int n_regions,
>                                      void *priv)
>
> So those regions will be created directly and the interface will be smaller
> and easier.
>
> Don't waste much time on this suggestion, as I said before I did not study
> much the fpga-region.c code and perhaps this is not possible and I'm just
> speaking rubbish :)
> </suggestion>
>
>
>> > Probably this is true 99.99% of the
>> > time.
>> > Let me open in parallel another point: why fpga_region is not a child
>> > of fpga_manager?
>>
>> FPGA regions are children of FPGA bridges.
>>
>> Alan
>
>
> --
> Federico Vaga
> [BE-CO-HT]
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
