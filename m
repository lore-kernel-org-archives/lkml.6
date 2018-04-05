Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDESn1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 14:43:27 -0400
Received: from mail-sn1nam01on0072.outbound.protection.outlook.com ([104.47.32.72]:64211
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751813AbeDESnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 14:43:24 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Daniel Vetter <daniel@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 0/3] drm: page-flip with damage
Thread-Topic: [RFC 0/3] drm: page-flip with damage
Thread-Index: AQHTzG/KwKs3+5anc0ah+4EEcE3MZaPxxCCAgAC8dIA=
Date: Thu, 5 Apr 2018 18:43:22 +0000
Message-ID: <BN6PR05MB31068D4ECB01090CD6FA682EBABB0@BN6PR05MB3106.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <20180405071957.GO3881@phenom.ffwll.local>
In-Reply-To: <20180405071957.GO3881@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR05MB3665;7:sXRZ4GzICWtKA75L+d9ZvnHjmgD1nOonxt4xnfSO6GNNXy7eNy+0hta0S4Ns5Xihiiagzbx9qZoMeSfTvWxsoRd5zTeJXh7+yKFgZSj+gGgV/eaoqtO5IAIlvFPumBFSGFl5BPcLrKn9A/Lj3gSi6F+Wgrf1TUzNzudPj24B7i7QVozTg5n1gnFq/NXLjQQSoCHtRPfqyzafPmcSg4djV02wQTXc/fN9LvTN63KEpwg+F8CdtO6Vm74E8xUGYJtE;20:hjrOw00V1bjdTPMb7jt7rbrEF6qloh9J1RUCXpI2XVgzrB+MR6Dj0tDTD98O7ch3vn0GzO8HJ04WeO+F4UzlnaP3wn+EXRjD5RLEnPHOce2/VYEIVeD6VeGZpZo9/A/Qt6QSnNs4jFVjdqY82M0tXiFtFpz9cK4aMm5DvlaEGqc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6998dc20-4519-473a-5ec7-08d59b251bbc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR05MB3665;
x-ms-traffictypediagnostic: BN6PR05MB3665:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BN6PR05MB3665EB1A2E8EC6371E6E913CBABB0@BN6PR05MB3665.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(10436049006162);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR05MB3665;BCL:0;PCL:0;RULEID:;SRVR:BN6PR05MB3665;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(53754006)(189003)(199004)(3846002)(6116002)(186003)(8936002)(105586002)(229853002)(26005)(81166006)(102836004)(81156014)(8676002)(66066001)(446003)(476003)(2906002)(11346002)(106356001)(97736004)(5660300001)(2900100001)(4326008)(7416002)(74316002)(305945005)(478600001)(7736002)(25786009)(6246003)(39060400002)(6916009)(14454004)(966005)(53936002)(6436002)(6306002)(55016002)(5250100002)(9686003)(59450400001)(76176011)(86362001)(575784001)(3280700002)(99286004)(5890100001)(54906003)(6506007)(7696005)(316002)(33656002)(486006)(3660700001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR05MB3665;H:BN6PR05MB3106.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: inwfwpoX7TDe6BhsN5i7Vqiny66JuwXK6EoTT/qaFsoWF/FKZ7duADYefS7m75BJXyc0zZIJFdbhieV7FANx2DtEsavrYUNFXAFP/D7vkFIAht//9VtjVBR4BZe793r+KUJsxjrwTL/I0voWlC+CUk4jJZqZRtxTADpj3tIyi03DRVxBMkmI8LYXOSLXuj/iKyvCEi9ESWTkNNi+ypbJ4k0UUHoe7uhCGRm09npYqLuXJ/T/HkR6lix2e2jt0gJokiTaI9D6NJIpjHzqHwA6rtrQAdg1nsZxxNKipW45DEjEFl0kl3ITr8m9Be8TpOlvM5DZ1be9exwpIY1GOrtsLSytxxDHfLYhRK412TfNv06fUKROhstIFz7LXUPpSO1Bt0yt1UGNT1N8z1uWXjv1T6Z18oW91bv3RivYldJP6+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6998dc20-4519-473a-5ec7-08d59b251bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 18:43:22.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB3665
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35IhWZV000438

> 
> On Wed, Apr 04, 2018 at 04:49:05PM -0700, Deepak Rawat wrote:
> > Hi All,
> >
> > This is extension to Lukasz Spintzyk earlier draft of damage interface for
> drm.
> > Bascially a new plane property is added called "DAMAGE_CLIPS" which is
> simply
> > an array of drm_rect (exported to userspace as drm_mode_rect). The clips
> > represents damage in framebuffer coordinate of attached fb to the plane.
> >
> > Helper iterator is added to traverse the damage rectangles and get the
> damage
> > clips in framebuffer, plane or crtc coordinates as need by driver
> > implementation. Finally a helper to reset damage in case need full update is
> > required. Drivers interested in page-flip with damage should call this from
> > atomic_check hook.
> >
> > With the RFC for atomic implementation of dirtyfb ioctl I was thinking
> > should we need to consider dirty_fb flags, especially
> > DRM_MODE_FB_DIRTY_ANNOTATE_COPY to be passed with atomic
> > DAMAGE_CLIPS property blob? I didn't considered that untill now. If no
> driver
> > uses that in my opinion for simplicity this can be ignored?
> 
> Last time I've checked no driver nor userspace really used this. I'd drop
> it for the new uapi like you've done.

Thanks Daniel for the review.
Agreed, will drop dirty_fb flags unless someone has any objection.

> 
> > About overlaping of damage rectangles is also not finalized. This really
> > depends on driver specific implementation and can be left open-ended?
> 
> Overlapping is userspace being stupid imo :-) I guess we should say that
> drivers should at least not fall over overlapping rects, and if they can't
> handle them, either coalesce into one big rect, or split them on their own
> somehow.

I think the best is to suggest user-space to not send overlapped rects. But
as someone earlier suggested it is hard or I should say unnecessary check
to enforce this in driver.

> 
> > My knowledge is limited to vmwgfx so would like to hear about other
> driver use
> > cases and this can be modified in keeping other drivers need.
> >
> > Going forward driver implementation for vmwgfx and user-space
> implementation
> > of kmscube/weston will be next step to test the changes.
> 
> I think an implementation for -modesetting and weston would be perfect.
> Kmscube has very littel value for damage tracking purposes (it's not a
> full compositor, just renders new frame each scene). And for kms I'm not a
> fan of using vendor-specific drivers to demonstrate new generic uapi - way
> too big chances you're making some vendor driver specific hardcoded
> assumption that doesn't hold anywhere else. Also makes it harder for
> others to test-implement your uapi in their drivers.
> -Daniel

Agreed implementation in modesetting and Weston and for kernel part as
I read in another mail dirty_fb implementation is also a good use-case.

> 
> >
> > Thanks,
> > Deepak
> >
> > Deepak Rawat (2):
> >   drm: Add helper iterator functions to iterate over plane damage.
> >   drm: Add helper to validate damage during modeset_check
> >
> > Lukasz Spintzyk (1):
> >   drm: Add DAMAGE_CLIPS property to plane
> >
> >  drivers/gpu/drm/drm_atomic.c        |  42 +++++++++
> >  drivers/gpu/drm/drm_atomic_helper.c | 173
> ++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/drm_mode_config.c   |   5 ++
> >  drivers/gpu/drm/drm_plane.c         |  12 +++
> >  include/drm/drm_atomic_helper.h     |  41 +++++++++
> >  include/drm/drm_mode_config.h       |  15 ++++
> >  include/drm/drm_plane.h             |  16 ++++
> >  include/uapi/drm/drm_mode.h         |  15 ++++
> >  8 files changed, 319 insertions(+)
> >
> > --
> > 2.7.4
> >
> 
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> https://urldefense.proofpoint.com/v2/url?u=http-
> 3A__blog.ffwll.ch&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=zOOG28inJK
> 0762SxAf-
> cyZdStnd2NQpRu98lJP2iYGw&m=CrefGziKAEk50MpTaNv64iDljHY7GesUlFHZc
> hWpiqI&s=gFk0ko5cD_cnIyPuZOrqyAwLsmTt9PiSDbWdHoi-8cU&e=
