Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDJS4Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:56:16 -0400
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:31264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751600AbeDJS4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:56:15 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
CC: "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>
Subject: RE: [RFC 0/3] drm: page-flip with damage
Thread-Topic: [RFC 0/3] drm: page-flip with damage
Thread-Index: AQHTzG/KwKs3+5anc0ah+4EEcE3MZaP5reKAgACyU8A=
Date: Tue, 10 Apr 2018 18:56:12 +0000
Message-ID: <SN6PR05MB39502480F2F2F8CA12A45848BABE0@SN6PR05MB3950.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <5f3e1c8a-d2b9-41f9-46f6-2b7f8c736de8@displaylink.com>
In-Reply-To: <5f3e1c8a-d2b9-41f9-46f6-2b7f8c736de8@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB4030;7:uy2i/Iy77a0ly3yx6328fAmXAfBAPcP+pv++3NrL9YoiunQcQxjt3jPPWbIlq6atMio1Urzo1Pzbxd007slp64ggMx9C/T70nWxy9wiJgf+Hab7RuqYJasc1SLDlsV8eUc7OhdktPHWVcm4R1Z0bunGEtlbzZio0Sz7CuAATENrShYc6RP0IXE+gznDW9krBqp0M9+l8xdUi+xcepoqSyDixsT7bb89daaX6XUEiJALL7vcY6AZk7GZRvlBLm9tu;20:MnLg5mNEcugYZ1I8lWZENctNKKVEXX3QTUhDo7gyZNfO9AB+h1LNnN4S4Wu2CmDQVTdZ6WZOIRhNhX409zHfg6WGW4qNihQGdm8G/6rp5154eJrsS0RirUmfLkKqmvh3W1sVOW34QtE8KHYOlZEWtS2Z7w0gOyOj/IYUo4T5VsI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: bf827fd0-bc21-4ee7-aef4-08d59f14bae6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4030;
x-ms-traffictypediagnostic: SN6PR05MB4030:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN6PR05MB4030FCB7C6E1DF388F9B8C3DBABE0@SN6PR05MB4030.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN6PR05MB4030;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4030;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(346002)(396003)(376002)(53754006)(199004)(189003)(99286004)(6436002)(55016002)(68736007)(53936002)(54906003)(316002)(6916009)(2900100001)(9686003)(3846002)(5250100002)(476003)(6116002)(3280700002)(3660700001)(5890100001)(59450400001)(11346002)(6506007)(102836004)(105586002)(446003)(106356001)(81166006)(8676002)(81156014)(2906002)(14454004)(8936002)(6246003)(7696005)(76176011)(478600001)(97736004)(86362001)(66066001)(74316002)(7736002)(229853002)(25786009)(26005)(305945005)(486006)(186003)(39060400002)(4326008)(33656002)(107886003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4030;H:SN6PR05MB3950.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: XDnhDzh8zrlDpmkkBTaDRELq9m30k6kMpsbhnMsWw7djrTfXn5/f7IeeA8UIQOIkuVJGmYpUBMTw7vTIlk5hegm2oRh7tiA1ZEQkGD1OxRIrAHpIMyUie6KQy1U3ajk1GupPnfZ7UTh2YsQrREcV2PAyLdKsEr0k7VpZFavBPU3QCs04fCXwvveT8DOMfG9afoGy63RNZ5G1yMzaCrvFtT4n6htwmE8zshsUynnyZX9/KChoNxZm2Adwq6R2tARaYP1KW2zMnK5NwL14rgphWOuL+EpMmNf9vuJ55TNY2ThSxHQ8JUNaqWPDfGHGoxXTvKg3olWY6bYHloUBjpUW/gcxvwagT24Fq8VN502zr65Qp22mLWuoJGmwI2x7uSX77doKu1UdaM5Trm3ObWWj1dLiaqDUWpYRko3oWog8SZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf827fd0-bc21-4ee7-aef4-08d59f14bae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 18:56:12.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3AIuLjW020657

>Hi,
>
>Many thanks that you have picked it up.
>Unfortunately I didn't had time to work on it for a while.
>
>I am ok with what you have done, ihmo the review is going in good direction.
>I will try not to miss your update of it.
>From my side I can say that damage rects with frame-buffer coordinates are perfectly fine for DisplayLink case.
>
>Btw I have noticed that there is also a patch from Rob Clark that is supplying helper for legacy dirtyfb callback.
>Maybe we should unify the naming of the rects. Here we have "damage_clips", Clark's patch has 'dirty_rects' notion.
>On other hand existing legacy dirtyfb callback in drm_framebuffer_funcs is also using 'clip_rects' :).

The reason to name it damage is inspired by eglSwapBuffersWithDamageKHR
which user-space will be calling before submitting a page-flip. So it makes naming
consistent and in sync with user-space.

>
>Thanks
>
>Łukasz Spintzyk
>
>On 05/04/2018 01:49, Deepak Rawat wrote:
>Hi All,
>
>This is extension to Lukasz Spintzyk earlier draft of damage interface for drm.
>Bascially a new plane property is added called "DAMAGE_CLIPS" which is simply
>an array of drm_rect (exported to userspace as drm_mode_rect). The clips
>represents damage in framebuffer coordinate of attached fb to the plane.
>
>Helper iterator is added to traverse the damage rectangles and get the damage
>clips in framebuffer, plane or crtc coordinates as need by driver
>implementation. Finally a helper to reset damage in case need full update is
>required. Drivers interested in page-flip with damage should call this from
>atomic_check hook.
>
>With the RFC for atomic implementation of dirtyfb ioctl I was thinking
>should we need to consider dirty_fb flags, especially
>DRM_MODE_FB_DIRTY_ANNOTATE_COPY to be passed with atomic
>DAMAGE_CLIPS property blob? I didn't considered that untill now. If no driver
>uses that in my opinion for simplicity this can be ignored?
>
>About overlaping of damage rectangles is also not finalized. This really
>depends on driver specific implementation and can be left open-ended?
>
>My knowledge is limited to vmwgfx so would like to hear about other driver use
>cases and this can be modified in keeping other drivers need.
>
>Going forward driver implementation for vmwgfx and user-space implementation
>of kmscube/weston will be next step to test the changes.
>
>Thanks,
>Deepak
>
>Deepak Rawat (2):
>drm: Add helper iterator functions to iterate over plane damage.
>drm: Add helper to validate damage during modeset_check
>
>Lukasz Spintzyk (1):
>drm: Add DAMAGE_CLIPS property to plane
>
>drivers/gpu/drm/drm_atomic.c | 42 +++++++++
>drivers/gpu/drm/drm_atomic_helper.c | 173 ++++++++++++++++++++++++++++++++++++
>drivers/gpu/drm/drm_mode_config.c | 5 ++
>drivers/gpu/drm/drm_plane.c | 12 +++
>include/drm/drm_atomic_helper.h | 41 +++++++++
>include/drm/drm_mode_config.h | 15 ++++
>include/drm/drm_plane.h | 16 ++++
>include/uapi/drm/drm_mode.h | 15 ++++
>8 files changed, 319 insertions(+)
>
>-- 
>2.7.4
>
