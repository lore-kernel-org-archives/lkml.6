Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F38BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2929D20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfBUHOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:14:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:15184 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfBUHOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:14:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 23:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,394,1544515200"; 
   d="asc'?scan'208";a="126075896"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2019 23:14:34 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland\@arm.com" <mark.rutland@arm.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko\@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v4 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
In-Reply-To: <BYAPR07MB470939C6F100336BAF6C41BFDD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com> <1550173514-23573-7-git-send-email-pawell@cadence.com> <67da432f-9c95-d644-65b5-dbc5b942d24c@ti.com> <BYAPR07MB47091C199971D677DE0FBB84DD7D0@BYAPR07MB4709.namprd07.prod.outlook.com> <e8616274-b0a8-6e59-b6fa-a68fed58bad7@ti.com> <BYAPR07MB470939C6F100336BAF6C41BFDD7D0@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Thu, 21 Feb 2019 09:14:30 +0200
Message-ID: <87va1dbokp.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

(please break your emails at 80-columns)

Pawel Laszczak <pawell@cadence.com> writes:
>>> One more thing. Workaround has implemented algorithm that decide for wh=
ich
>>> endpoint it should be enabled.  e.g for composite device MSC+NCM+ACM it
>>> should work only for ACM OUT endpoint.
>>>
>>
>>If ACM driver didn't queue the request for ACM OUT endpoint, why does the
>>controller accept the data at all?
>>
>>I didn't understand why we need a workaround for this. It should be stand=
ard
>>behaviour to NAK data if function driver didn't request for all endpoints.
>
> Yes, I agree with you. Controller shouldn=E2=80=99t accept such packet. A=
s I know this
> behavior will be fixed in RTL.
>
> But I assume that some older version of this controller are one the marke=
t,
> and driver should work correct with them.
>
> In the feature this workaround can be limited only to selected controller=
s.
>
> Even now I assume that it can be enabled/disabled by module parameter.

no module parameters, please. Use revision detection in runtime.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxuT9YACgkQzL64meEa
mQb0KA/9G9q4320JmbOLoOs7lhzSroaa+cRfzRqvFN84Wt1jcLdbt427Hmei9KQD
hSuWJCN8XfbS0SQouEf+ijLXOloQoj++Po57Vr9hhlciVwbfd//pREYlwv3KqEhc
9B29m84tEBl762fesbu+r6jEhyIEFoj5QvKSQQQ6Sn3mjBwDHuX9rT6XPqYBgR93
uemDLnIKVpt/U56jVtkTofBSEFnlaQXnCMjrB7pZhWLUG0WEPABJ+3oyVBGqzEYQ
Cqw8QTh/jr1EB4qj9ArHOXPRqC0NXFhWLNV3N/BuN0No/yVeVv/WntgXMUo4aOQ6
veeG3/YuvO3UxzrR3ChUkqQXpQK0oynIjOdCSEuZ8EyWjHlPfYParu0y0M86RZCN
uMQLBt53g3gOtoyfEq0U9Xn6fxeIXVB2SPWBJrL/dt+0iLfksS634RxD4xH90jp+
RkktSilOQzwHqhlvF+SWC/ilY4Y4NKheFN3MAz7USTyBDhIKaxkQg9aZmQf5Vr/F
puC3+syTKBrnmF6bPaTzvSQJJ+zYO6Dyhs7EsZDET3+ye08BZB7KDC5h3SsISeY2
vHG6NxaZm37kzY9d6MkOC9JYupyQhLbHD0imgYAEjU7DncNjlR2Fb5N1JNgW9pxV
5qQeZbY4dVJycXG8vrrLEnB6oBM4tJFpCiBN6vyG+//+RQ5jmPM=
=9xvx
-----END PGP SIGNATURE-----
--=-=-=--
