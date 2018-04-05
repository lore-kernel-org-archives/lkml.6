Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDFAAA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:00:00 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:15904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeDEX76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:59:58 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
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
Subject: RE: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Thread-Topic: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Thread-Index: AQHTzG/QxRDvLNOwKUiQ/1JAGDt4gKPxzRuAgAAQqACAAP02kA==
Date: Thu, 5 Apr 2018 23:59:57 +0000
Message-ID: <MWHPR05MB3117ABEF02B500A3558FB14BBABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
 <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
In-Reply-To: <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR05MB3312;7:U8DOgPsSg0kZdcKXhk6q6jQxv0RClKPXOa5A0wte+cDfbdS9CGBJUhpN48stuc/Tx/gc3toLyHMV+B9BpGaymfe5EMpxFXL3wvmWfvSTP9KdcCJluMa1TzxZ5g3mEjoMV2r0zRL3DyrYkWG5llb4l5iBh+wEz2MuVTwZrWO4dBRRi+5WSWDkL9EN2QztwKkai/LKXH2GazfBsAw3CXTsdJMioZhRfVZRD7CJ/ZigSh+X77pw++RpTrPhtZ1QBuXZ;20:C7bjzo88+nd3lrVvMcwGHZjeJWsGmSVc8ItPym7WienRuAa7OQEGd6JguXY1vQmV1ESf8OrC48I2xu/YjBSNUcb0fcHidozWNoMefoqtTkjDeIQfW691aYOsJKKxPEMFdBanTqGcZUUh8T+K22nvKaFHrtvkutKavQBJfT1i2KE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ece7e64b-a217-4294-3ae4-08d59b515599
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB3312;
x-ms-traffictypediagnostic: MWHPR05MB3312:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MWHPR05MB331234821B366E894DBEC3D9BABB0@MWHPR05MB3312.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR05MB3312;BCL:0;PCL:0;RULEID:;SRVR:MWHPR05MB3312;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(39380400002)(366004)(346002)(189003)(199004)(8676002)(316002)(8936002)(5660300001)(2201001)(81166006)(7416002)(102836004)(86362001)(53546011)(81156014)(229853002)(11346002)(446003)(6506007)(7696005)(110136005)(99286004)(476003)(97736004)(76176011)(478600001)(74316002)(6436002)(106356001)(55016002)(6246003)(53936002)(68736007)(93886005)(14454004)(2900100001)(2906002)(3846002)(6116002)(26005)(305945005)(66066001)(105586002)(3280700002)(5250100002)(39060400002)(25786009)(3660700001)(9686003)(7736002)(33656002)(486006)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3312;H:MWHPR05MB3117.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XvYHejMaA0PP8ahE1DQbC0w4mcHbfSiw68v6B2zjssEELnp/D5bbE2g9BlBsU8jHSBX1cQ3zXEIIPK/UTHVvfuptL1LMhP9Q8f1dBrfDTSj/U84EEpSZGC1vwUI05FFTvDrbxGIhDsrH4gdNwxsNmaF9QFUrft7RHHW9/8JYUN7ddcufxlJSt9TNlcY8GZ7JfAZDc/6hhs3MQKYPj/6IahH8EgMLKhIdzh2PCSe5r1THtcSAJNSISsiHXcXw1ezMNaUOw51VnqX1iGiX09DsZMn1CS54TmZjFs9wLXF1aHoLbEWdoSZpXLpZiEQIsPzvUXIgL0eKrFtVgiBt1QbEixSL+5jtZeUyTEGUDd3TNBY3GNyd5Po6i9t8KHIoG8VnRyt1xT85F1Z4Ya6H3RIZu0XklhepK8QAUYxEq5IQM8U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece7e64b-a217-4294-3ae4-08d59b515599
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 23:59:57.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w36005vt032719

> plane damage.
> 
> On 04/05/2018 09:52 AM, Daniel Vetter wrote:
> >
> > TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
> 
> I'm assuming CRTC plane coordinates here. They are used for uploading
> contents of hardware planes. Like, in the simplest case, cursor images.

Yes they are CRTC plane coordinates, so is TYPE_PLANE naming confusing ?
And should be named to TYPE_CRTC_PLANE but then it is confusing with
TYPE_CRTC.

> 
> /Thomas
