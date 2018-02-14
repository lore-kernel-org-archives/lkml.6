Return-Path: <Michael.H.Kelley@microsoft.com>
X-Google-Smtp-Source: AH8x224gXySplfLRwALV9ZsAOghkW7TGf0wGmn7ZyD1ATNXG+YT24eGPC4l7shsgNmbcN4fVNfoc
ARC-Seal: i=1; a=rsa-sha256; t=1518574341; cv=none;
        d=google.com; s=arc-20160816;
        b=cxfWVbOGG4dO9bClnaURtMt+6UgCyuWYzMmnHcaB3DsF60qodxJF9tpGjQOZXgbywi
         fmNPmKnoNCJAbnU79GdFzXxQPHipj++j1WBfKYXGmIuogIwVV62NskLFp6u9VWfwuCy0
         LsVFrM4+v5Yj9XuWuQmqbjWE5dKuaono0RRjO85ASNHXFMoWcmyFEmy1dMrVJFqg4+Pl
         mjg7kQrm6LT6nYkwd+ymmAY+GVIkoqYTrbnNB1WfAikao53HFZn37kB7d05willrghO2
         qMFr+4A6MQ468m04dH4nJsFweU0tC9aPHP6L5g54kXeypjXUH5OMaKoRDv5+Dd50AX+G
         6cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2uvQK0bS7y51PZIgrVr3uXpQKbI0YWdXgcs5DYZ2bFc=;
        b=v/eP++LFBGOt3+b+VbWAjlXND/1OEs9kYKUd0cFfw6v88mbXN4FdJuQBWQtbudQwme
         6idrZixlS86x/rJsUbCfjmt0MipZFRh1UIG6SBQXyWEeelbfPyGg1YVKZw0vakICI0hH
         WUHgDL51T/wsLRTK69jZ7qb/Hd0nAu0+t2owMvnty8182wy/9VOKXgT1AwBZ+ilgtRy8
         Mxer0sBDskE3sdhNeA2TKShd2ccN0QNS2PNXrjXmkrfAT2WJYxeMcDQFsDfoF++oPI3x
         cwPry7uSvWxPSpA9/+Qt12z3e1OkQFeT3604twAQ9udHdYS2WFaPpnCRYDlgTOZqEPqh
         i4Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UEvOT0kX;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.42.138 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=UEvOT0kX;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.42.138 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Michael Kelley
	<mhkelley@outlook.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "leann.ogasawara@canonical.com"
	<leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
	<marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Index: AQHTorCNaQB4t9RCq0qElSZLQrwNpaOinHeAgACOaAA=
Date: Wed, 14 Feb 2018 02:12:08 +0000
Message-ID: <DM5PR2101MB103050ABCE48F08BF383EEEFDCF50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
 <20180213093439.3698cb5e@xeon-e3>
In-Reply-To: <20180213093439.3698cb5e@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-02-14T02:12:06.4826779Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [72.234.30.88]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:sFgveDYBXqDOgqyZ+2oYku6bm2dwR11V4eIHP11hWYxBFUtABofS9y1bZMDbp3UBhNooICXe8RRXJbjs1UDNbyusd94v8jksGGWpqjdZWrgtbyFEWLS46pgxqO7klorOq4Wh1wKPvkbwuyLLAYbKzvXhaPJF0FvQTyODoWRvlqHWYSNCcAWYttm03URh3e8DtlrvG0u2jgqb6a2LGThlJKFnEulqh4YPwpQBtPDvIczSGouh78Y+kF07QZ+iSF9d
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04996178-67b0-45f2-d5e7-08d573505a10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
x-microsoft-antispam-prvs: <DM5PR2101MB090192D0006AC2A1A120D497DCF50@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001016)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0583A86C08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(13464003)(199004)(189003)(33656002)(74316002)(4326008)(305945005)(2950100002)(39060400002)(10290500003)(2906002)(7416002)(106356001)(3280700002)(7736002)(229853002)(72206003)(5660300001)(478600001)(68736007)(14454004)(25786009)(10090500001)(5250100002)(66066001)(8990500004)(53936002)(9686003)(8676002)(3846002)(6246003)(6436002)(6116002)(55016002)(107886003)(105586002)(26005)(6346003)(3660700001)(102836004)(81166006)(81156014)(97736004)(22452003)(86362001)(186003)(7696005)(316002)(2900100001)(110136005)(86612001)(8936002)(6506007)(76176011)(54906003)(53546011)(99286004)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: wBxFqh1/tiPXDllBhwKZYvbP9luyD8vSZ8gf/ujajHKgvAnJAKqcyBrmRuzIrUko0jydoOMAAcNdTQm+4bbVlQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04996178-67b0-45f2-d5e7-08d573505a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 02:12:08.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592048464766251915?=
X-GMAIL-MSGID: =?utf-8?q?1592340608909366816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, February 13, 2018 9:35 AM
> To: Michael Kelley <mhkelley@outlook.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; gregkh@linuxf=
oundation.org;
> linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.d=
e;
> apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen Hemmi=
nger
> <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer si=
gnaling
>=20
>=20
> >  	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
> >  		u32 pending_sz =3D READ_ONCE(rbi->ring_buffer->pending_send_sz);
> >
> >  		/*
> > +		 * Ensure the read of write_index in hv_get_bytes_to_write()
> > +		 * happens after the read of pending_send_sz.
> > +		 */
> > +		virt_rmb();
> > +		curr_write_sz =3D hv_get_bytes_to_write(rbi);
> > +
> > +		/*
> >  		 * If there was space before we began iteration,
> >  		 * then host was not blocked. Also handles case where
> >  		 * pending_sz is zero then host has nothing pending
> >  		 * and does not need to be signaled.
> >  		 */
> > -		if (orig_write_sz > pending_sz)
> > +		if (curr_write_sz - delta > pending_sz)
> >  			return;
> >
> >  		/* If pending write will not fit, don't give false hope. */
> > -		if (hv_get_bytes_to_write(rbi) < pending_sz)
> > +		if (curr_write_sz <=3D pending_sz)
> >  			return;
> > +
> > +		vmbus_setevent(channel);
> >  	}
> >
> > -	vmbus_setevent(channel);
> >  }
>=20
> I think this won't work on older versions of Windows where feat_pending_s=
z
> is never set.  On those versions vmbus_setevent needs to always be called=
.

The older Windows/Hyper-V hosts poll if they can't write to the
host->guest ring buffer because it is full.   We don't want to call
vmbus_setevent() every time through this routine because then
the guest would be signaling the host every time the host interrupts
the guest.

Michael
