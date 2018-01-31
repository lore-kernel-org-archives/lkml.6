Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeAaL6A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:58:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21845 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeAaL55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:57:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180131115755epoutp02e9a075ed50ea1bb510582b6aa7694d46~O4yWzuZmy2897528975epoutp02B
X-AuditID: b6c32a46-3a9ff70000001029-42-5a71af428650
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix loading of module radeonfb on PowerMac
Date: Wed, 31 Jan 2018 12:57:51 +0100
Message-id: <2327325.HZp8yQY9TN@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CA+7wUsxXE=QDsGvYOPzW+kdd1OjHnEikUjusQXNNFUuTbdbQTQ@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZdljTVNdpfWGUwfufFhYfmlqZLa58fc9m
        caLvA6vF5V1z2CxefFvDZHF201sWi/Xzb7E5sHt8XTWb3eNX21xmj543Lawe97uPM3kcv7Gd
        yePzJrkAtigum5TUnMyy1CJ9uwSujCVHX7IVrHaq+Lx4EWMDY7dJFyMnh4SAicTlnQ3sXYxc
        HEICOxglDq2bxQjhfGeUmLNhLwtM1YcNLVBVGxglFl3qYIVwvjJKPH3RwQRSxSZgJTGxfRUj
        iC0ioCFx68pzti5GDg5mgblMEn8tQcLCAk4SX6dtBSthEVCV2H1xPlgrr4CmxMyWz+wgtqiA
        l8SWfe1gcU6BYIk7fb+ZIWoEJX5Mvgd2ELOAvMS+/VNZIWwdibPH1oFdLSFwgk3i3I9fzBBX
        u0hMvvcQ6gNhiVfHt7BD2NISz1ZtZISwpzNKbP8tAdG8mVFi1e4JUEXWEoePX4TawCfRcfgv
        O8gzEgK8Eh1tQhAlHhJNXW/ZIGxHiUUNl1gggfKbUWL1219MExhlZyE5fBaSw2chOXwBI/Mq
        RrHUguLc9NRiowIjveLE3OLSvHS95PzcTYzghKHltoNxyTmfQ4wCHIxKPLwcFQVRQqyJZcWV
        uYcYJTiYlUR4v8UURgnxpiRWVqUW5ccXleakFh9ilOZgURLnbQ1wiRISSE8sSc1OTS1ILYLJ
        MnFwSjUwzv22TcNa1WxLRNoX/53HJad9Z5C0Xuog48i8tmLm1hhfZ4HD6kVtwdNvfCh8uXLL
        h0yBjUWFYXn3vf18Xeas7l0+yXwCo3XSzcgIb5aralcPWBTkrduRLs60c67Rq3X34/fNUfh3
        U/71L7n0NqOpHjrepeaJW9bFZaSWPX+erKrZqR+8avdOJZbijERDLeai4kQADdsqDxQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t9jQV2n9YVRBl9XKFh8aGpltrjy9T2b
        xYm+D6wWl3fNYbN48W0Nk8XZTW9ZLNbPv8XmwO7xddVsdo9fbXOZPXretLB63O8+zuRx/MZ2
        Jo/Pm+QC2KK4bFJSczLLUov07RK4MpYcfclWsNqp4vPiRYwNjN0mXYycHBICJhIfNrSwdzFy
        cQgJrGOUWPBpCpTzlVHi8c+LrCBVbAJWEhPbVzGC2CICGhK3rjxnAyliFpjLJDGt8TszSEJY
        wEni67StYEUsAqoSuy/OZwKxeQU0JWa2fGYHsUUFvCS27GsHinNwcAoESxx5pw2xbDmjxKvG
        f4wQ9YISPybfYwGxmQXkJfbtn8oKYWtJrN95nGkCI/8sJGWzkJTNQlK2gJF5FaNkakFxbnpu
        sVGBUV5quV5xYm5xaV66XnJ+7iZGYIhvO6zVv4Px8ZL4Q4wCHIxKPLwJVQVRQqyJZcWVuYcY
        JTiYlUR4v8UURgnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLg
        lGpgDJ5Zuf6j4+I+x7NiTlK/bL1Ynq4xDyyyDX90Zar+48Dblr63D3M82ubv2PXP+rqu3Jvt
        i/quzXKRbf+fcrbk3UTubLE87+NKDLuUDUr5YqYe33zG80DRGpPZtQF6DArfV+RtmrzTZS67
        8oJ3dl/867c1HzjTJ5L2bV+RvI+71/eYKSK/u+6rK7EUZyQaajEXFScCAH5yiittAgAA
X-CMS-MailID: 20180131115754epcas2p12bd0a640170ed132f356853c9e2b8790
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180131115754epcas2p12bd0a640170ed132f356853c9e2b8790
X-RootMTR: 20180131115754epcas2p12bd0a640170ed132f356853c9e2b8790
References: <1479153557-20849-1-git-send-email-malat@debian.org>
        <1565457.zQ5DZdIQMY@amdc3058>
        <CA+7wUsxXE=QDsGvYOPzW+kdd1OjHnEikUjusQXNNFUuTbdbQTQ@mail.gmail.com>
        <CGME20180131115754epcas2p12bd0a640170ed132f356853c9e2b8790@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 30, 2018 02:14:10 PM Mathieu Malaterre wrote:
> Bartlomiej,
> 
> On Wed, Jan 3, 2018 at 3:47 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > On Thursday, December 21, 2017 11:07:56 PM Mathieu Malaterre wrote:
> >> When the linux kernel is build with (typical kernel ship with Debian
> >> installer):
> >>
> >> CONFIG_FB_OF=y
> >> CONFIG_VT_HW_CONSOLE_BINDING=y
> >> CONFIG_FB_RADEON=m
> >>
> >> The offb driver takes precedence over module radeonfb. It is then
> >> impossible to load the module, error reported is:
> >>
> >> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> >> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> >> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> >> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> >>
> >> This patch reproduce the behavior of the module radeon, so as to make it
> >> possible to load radeonfb when offb is first loaded.
> >>
> >> It should be noticed that `offb_destroy` is never called which explain the
> >> need to skip error detection on the radeon side.
> >
> > This still needs to be explained more, from my last mail:
> >
> > "The last put_fb_info() on fb_info should call ->fb_destroy
> > (offb_destroy in our case) and remove_conflicting_framebuffers()
> > is calling put_fb_info() so there is some extra reference on
> > fb_info somewhere preventing it from going away.
> >
> > Please look into fixing this."
> 
> I am not familiar with the fb stuff internals but here is what I see:
> 
> # modprobe radeonfb
> 
> leads to:
> 
> [   52.058546] bus: 'pci': add driver radeonfb
> [   52.058588] bus: 'pci': driver_probe_device: matched device
> 0000:00:10.0 with driver radeonfb
> [   52.058595] bus: 'pci': really_probe: probing driver radeonfb with
> device 0000:00:10.0
> [   52.058608] devices_kset: Moving 0000:00:10.0 to end of list
> [   52.058613] radeonfb_pci_register BEGIN
> [   52.058634] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> <at this point radeon_kick_out_firmware_fb is called>
> [   52.058666] checking generic (9c008000 96000) vs hw (98000000 8000000)
> [   52.058667] fb: switching to radeonfb from OFfb ATY,RockHo
> [   52.058844] Console: switching to colour dummy device 80x25
> [   52.058860] device: 'fb0': device_unregister
> [   52.058956] PM: Removing info for No Bus:fb0
> [   52.059014] device: 'fb0': device_create_release
> <a call to do_unregister_framebuffer is done>
> <put_fb_info is done with a count=2 and dev=NULL>
> [   52.059048] device: 'vtcon1': device_unregister
> [   52.059076] PM: Removing info for No Bus:vtcon1
> [   52.059091] device: 'vtcon1': device_create_release
> [   52.059107] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem
> 0x98000000-0x9fffffff pref]
> [   52.256151] aper_base: 98000000 MC_FB_LOC to: 9bff9800, MC_AGP_LOC
> to: ffffa000
> [   52.256157] radeonfb (0000:00:10.0): Found 32768k of DDR 64 bits
> wide videoram
> 
> I can confirm that offb_destroy is never called (not sure exactly
> why), but in any case the call to radeon_kick_out_firmware_fb happen
> much earlier, at least before the put_fb_info.

It is okay, put_fb_info() is called indirectly by radeon_kick_out_firmware_fb()

radeon_kick_out_firmware_fb()
	remove_conflicting_framebuffers()
		do_remove_conflicting_framebuffers()
			do_unregister_framebuffer()
				put_fb_info()

offb_destroy() is not called because there is an extra reference on old
fb_info (->count == 2):

static void put_fb_info(struct fb_info *fb_info)
{
	if (!atomic_dec_and_test(&fb_info->count))
		return;
	if (fb_info->fbops->fb_destroy)
		fb_info->fbops->fb_destroy(fb_info);
}

The question is why there is an extra reference, probably user-space
is still holding the fb_info reference obtained in fb_open() call and
fb_release() is never called. Besides not calling fbops->fb_destroy()
this also causes missing call of fbops->fb_release() (in fb_release())
which some fb drivers are implementing (but not offb.c).

> Could you describe a bit more the chain of calls you were thinking of ?

Please add WARN_ON(1) to get_fb_info() and put_fb_info() so we can check
from the stacktrace if it is actually fb_open() that holds the extra
old fb_info reference.

drivers/video/fbdev/core/fbmem.c:

static struct fb_info *get_fb_info(unsigned int idx)
{
	struct fb_info *fb_info;

	if (idx >= FB_MAX)
		return ERR_PTR(-ENODEV);

	mutex_lock(&registration_lock);
	fb_info = registered_fb[idx];
	if (fb_info)
		atomic_inc(&fb_info->count);

if (fb_info)
	WARN_ON(1);

	mutex_unlock(&registration_lock);

	return fb_info;
}

static void put_fb_info(struct fb_info *fb_info)
{
WARN_ON(1);

	if (!atomic_dec_and_test(&fb_info->count))
		return;
	if (fb_info->fbops->fb_destroy)
		fb_info->fbops->fb_destroy(fb_info);
}

> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> Link: https://bugs.debian.org/826629#57
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
> >> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> >> ---
> >> v2: Only fails when CONFIG_PCC is not set
> >> v3: Only fails when CONFIG_FB_OF is not set, CONFIG_PCC was too broad. Since the conflicts in region is due to OFfb explicitly refers to it.
> >
> > It seems that there may still be configurations when this is
> > incorrect -> when offb drives primary (non-radeon) card and radeonfb
> > drives secondary (radeon) card..
> >
> >>  drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> >> index 4d77daeecf99..221879196531 100644
> >> --- a/drivers/video/fbdev/aty/radeon_base.c
> >> +++ b/drivers/video/fbdev/aty/radeon_base.c
> >> @@ -2259,6 +2259,22 @@ static const struct bin_attribute edid2_attr = {
> >>       .read   = radeon_show_edid2,
> >>  };
> >>
> >> +static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
> >> +{
> >> +     struct apertures_struct *ap;
> >> +
> >> +     ap = alloc_apertures(1);
> >> +     if (!ap)
> >> +             return -ENOMEM;
> >> +
> >> +     ap->ranges[0].base = pci_resource_start(pdev, 0);
> >> +     ap->ranges[0].size = pci_resource_len(pdev, 0);
> >> +
> >> +     remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
> >> +     kfree(ap);
> >> +
> >> +     return 0;
> >> +}
> >>
> >>  static int radeonfb_pci_register(struct pci_dev *pdev,
> >>                                const struct pci_device_id *ent)
> >> @@ -2312,19 +2328,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >>       rinfo->fb_base_phys = pci_resource_start (pdev, 0);
> >>       rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
> >>
> >> +     ret = radeon_kick_out_firmware_fb(pdev);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >>       /* request the mem regions */
> >>       ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
> >>       if (ret < 0) {
> >> +#ifndef CONFIG_FB_OF
> >>               printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
> >>                       pci_name(rinfo->pdev));
> >>               goto err_release_fb;
> >> +#endif
> >>       }
> >>
> >>       ret = pci_request_region(pdev, 2, "radeonfb mmio");
> >>       if (ret < 0) {
> >> +#ifndef CONFIG_FB_OF
> >>               printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
> >>                       pci_name(rinfo->pdev));
> >>               goto err_release_pci0;
> >> +#endif
> >>       }
> >>
> >>       /* map the regions */
> >> @@ -2509,10 +2533,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
> >>       iounmap(rinfo->mmio_base);
> >>  err_release_pci2:
> >>       pci_release_region(pdev, 2);
> >> +#ifndef CONFIG_FB_OF
> >>  err_release_pci0:
> >>       pci_release_region(pdev, 0);
> >>  err_release_fb:
> >>          framebuffer_release(info);
> >> +#endif
> >>  err_disable:
> >>  err_out:
> >>       return ret;
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> 
> Thanks,
> -M

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
