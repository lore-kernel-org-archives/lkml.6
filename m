Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDFAUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:20:04 -0400
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:26304
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751262AbeDFAUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:20:01 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Daniel Vetter <daniel@ffwll.ch>,
        Thomas Hellstrom <thomas@shipmail.org>
CC: Rob Clark <robdclark@gmail.com>,
        =?utf-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
Thread-Topic: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
Thread-Index: AQHTy50PdBb2akD7o0qY8CnX3q1Eo6PwLWIAgAAXfoCAAAXdAIAAB30AgAAM1QCAAc4nAIAAAYiAgACy9SA=
Date: Fri, 6 Apr 2018 00:19:55 +0000
Message-ID: <MWHPR05MB31175518B13832D3BF64E97ABABA0@MWHPR05MB3117.namprd05.prod.outlook.com>
References: <20180403224225.26776-1-robdclark@gmail.com>
 <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
 <307adb15-412a-1fe2-f116-27fe5b4a657d@shipmail.org>
 <20180404084320.GA3881@phenom.ffwll.local>
 <fa4074c7-5469-a69f-e4aa-bdc84e1a919a@shipmail.org>
 <20180404095604.GD3881@phenom.ffwll.local>
 <7616bf87-bd2e-5003-af35-bc95f0e2a912@shipmail.org>
 <CAKMK7uFMj8NFvSxxv3KnGhh1rpfbsci58kUaoBcwPtbKEVOiEA@mail.gmail.com>
In-Reply-To: <CAKMK7uFMj8NFvSxxv3KnGhh1rpfbsci58kUaoBcwPtbKEVOiEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR05MB2831;7:iZ3YQ9x3iaq1ZscKdUDqLF0DLH1KzoX/c2CqiP2HIOnHPlAiJb0LnVFWMDu8Q8QA/Pv27S01wTKsTc6qsuX2EdRVqbGdJu4ziBW8eHzxxf5CUZk4+FUjW3Ceyo45pUfi6TN3apVltKaYGy5mU5Nw6OefitPlm8cfI/l4sazI9b8iIc/oTdsCnCSl5nZG6wsQeAdydSwlf5cILr1oVTJ4jBMitbiz1C1Otitf1mys3hweVA8hwpGrfvwxdzxRDCDJ;20:cGTz852LwvVw2ID9XWOREQx5Ose22rE7nGL3QRNdW1+3N4ja1T6sGRX7/aJUjX5HsngkhVMtxatBF9Ehn4tjwFNhz2v4rvjPDLNpEHwcByN5tX6WyQWzw65i/pU/90gR7vP/YLwblxokjvpAE2LdOj/y17MrEClvaZgYxwaVuIk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58d4a5ee-4f24-40b0-a25f-08d59b541f95
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB2831;
x-ms-traffictypediagnostic: MWHPR05MB2831:
x-microsoft-antispam-prvs: <MWHPR05MB28317BD74CDD372B8F3D4F08BABA0@MWHPR05MB2831.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(10436049006162);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR05MB2831;BCL:0;PCL:0;RULEID:;SRVR:MWHPR05MB2831;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(199004)(189003)(7696005)(3660700001)(966005)(6436002)(6116002)(6306002)(11346002)(59450400001)(6506007)(3846002)(229853002)(102836004)(26005)(5250100002)(106356001)(7416002)(186003)(5660300001)(316002)(54906003)(93886005)(486006)(9686003)(97736004)(110136005)(2900100001)(6246003)(86362001)(5890100001)(476003)(8936002)(55016002)(53936002)(478600001)(105586002)(14454004)(4326008)(74316002)(446003)(3280700002)(2906002)(68736007)(99286004)(66066001)(305945005)(8676002)(76176011)(7736002)(25786009)(33656002)(81156014)(81166006)(39060400002)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB2831;H:MWHPR05MB3117.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hvn82OVwHglaxdim+hOH47a8qQcAjS29a3bJ35f43xcuaifmYnZmMIl/XIwxgHgHQbHsk76tAcFreVj7VSF/6OUc817qtlr0v9W4EkPpWLUc6j4gQcGVx14BbOgd9CIUObu1RMOhnEDWRaKBCpTbERcY7efIVETvkhrcmiXGsAqMAlCYZv3OXm1J0zcO/PI24v17l03Q+Ucp7IOkKgY5/RRkqbVZAkrbGa/xCmRnvcV1m+iqPjACEB89O+5C454ZZnn4PpWO9n2hu0BLjWJQ3VYw8wyV4zJtaL1cirxqVLWg4zRUzRZFzd+1Anj3hTyrDhI2K4XW8XSfk9l1N01HeDIxS4mubMK+EcI9hd33ay90oRXyBOyqFs2mcCgYcAFH6xKCRk7K359f0yk6R8SNKdnZJcsFU2DR8SvEtlG3AQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d4a5ee-4f24-40b0-a25f-08d59b541f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 00:19:55.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2831
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w360K9pQ000303

> >>> 1) Expose a dirty (or content_age property)
> >>> 2) Attach a clip-rect blob property.
> >>> 3) Fake a page-flip by ping-ponging two frame-buffers pointing to the
> >>> same
> >>> underlying buffer object.
> >>>
> >>> Are you saying that people are already using 3) and we should keep
> using
> >>> that?
> >>
> >> I'm saying they're using 3b), flip the same buffer wrapped in the same
> >> drm_framebuffer, and expect it to work.
> >>
> >> The only advantage dirtyfb has is that it allows you to supply the
> >> optimized upload rectangles, but at the cost of a funny api (it's working
> >> on the fb, not the plane/crtc you want to upload) and lack of drm_event
> to
> >> confirm when exactly you uploaded your stuff. But imo they should be
> the
> >> same underlying operation.
> >>
> >
> > FWIW, vmwgfx has always treated a dirtyfb as a pure front-buffer like
> > rendering operation without any synchronization,
> > We've guaranteed that only the rects that are present are uploaded, but
> only
> > xf86-video-vmware has taken advantage of this to keep
> > CPU- and GPU rendered content apart.
> > I think we've at some point run into problems with number of cliprects,
> (Old
> > KDE lock screen?) and use multiple dirtyfb for the same
> > update...
> 
> Ok, if we can hit this in practices then I think it's ok to have the
> limit. Just need to make sure userspace actually condenses the
> cliprects down to something within the limit, since with atomic flips
> you can't just do multiple updates - that would tear badly.

So I think the conclusion is to have damage clip rect limit with proper
documentation stating limitation of doing multiple updates.

> 
> Wrt not syncing: I think general use pretty clearly says lots of
> userspace renders into buffers with gpus (not even necessarily your
> own) and then expects dirtyfb or a flip to upload all the bits.
> Otherwise Rob Clark wouldn't need his patch. Given that I think we
> need to make general semantics follow that requirement - I don't
> expect it'll harm vmwgfx since it doesn't render into the frontbuffer
> anyway?
> 
> > IIRC the reason for working with the fb, is that it's much easier for
> > user-space, which doesn't have to care where planes are scanning out and
> > why.
> > "Present my new content on any screen that's affected".
> 
> Yeah, dirtyfb makes tons of sense for frontbuffer-rendering X, which
> also doesn't do per-scanout pixmaps. But for atomic flips you really
> want to flip on the crtc (or well plane), since otherwise with
> multiple planes it comes up all teared up. vmwgfx doesn't care I guess
> since you only have 1 primary plane, but all the SoC chips very much
> do.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - https://urldefense.proofpoint.com/v2/url?u=http-
> 3A__blog.ffwll.ch&d=DwIBaQ&c=uilaK90D4TOVoH58JNXRgQ&r=zOOG28inJK
> 0762SxAf-cyZdStnd2NQpRu98lJP2iYGw&m=XKgN7GPElFapBWdozPSC-
> 9rcfKmDvQC1QHhsFghexWc&s=SH9q5tw-
> UqpUBJVrr2v1mLpRo28Aau7iJ3YWlrgbPmU&e=
