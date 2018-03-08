Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935112AbeCHPIB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:08:01 -0500
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:45082
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754612AbeCHPH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:07:57 -0500
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jan Kara <jack@suse.cz>, Dexuan Cui <decui@microsoft.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: Any known soft lockup issue with vfs_write()->fsnotify()?
Thread-Topic: Any known soft lockup issue with vfs_write()->fsnotify()?
Thread-Index: AdOycop0dWu76knCT0ybPuj6bfAx4ACUMp0AAIqT54A=
Date: Thu, 8 Mar 2018 15:07:55 +0000
Message-ID: <BL0PR2101MB11085E320B6928A5A59DEF4ECADF0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <KL1P15301MB000645A10FE2B20421A7F3DBBFC50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180305204836.qznlcm6uwurfs2n4@quack2.suse.cz>
In-Reply-To: <20180305204836.qznlcm6uwurfs2n4@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-08T15:07:53.7158219Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:MvSrSrhuTPYvva3r/p0T37dQJll5TUmZALNbqA0THRzS4QeXdA4RuXYRqKFG7DbIVdgmGNfclqBq+QmGZcEHOWA1Z2/BMLh8TMYSVuTvoK3Pd5KVAiqYo3mLS0ItAOSSvTiv1ibf74gpIXOBSJab2f9Ojenue5iO8J6YqWRvLnbcenFPl0VPG+7U6KRsz4qAAaMqC5Hg4SHYStio8u6dAfa5Ubupnj97tI4fzd/yZVs/ppubBwnwI/vDAwErQtx2;20:Py1WB+orN0yP+W1vUfaxmgcgFjllRmfuzVR87x3ivyIyNBTpPFKo7eUsME3NBWEGcPpfn9+L/uSMihU0Us7YozpNjwNSzTRdT9ULsPnivgcWy11YUK9kK3YicLCo23Yd/4o31h/Io0E/rKZ9X3XK2qZR5qaEJ9j6GL98rEoZj+M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f31fcff0-0a67-4045-6138-08d585065f19
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB096288CD74E0E46451BBF6C4CADF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(166708455590820)(9452136761055)(189930954265078)(85827821059158)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(377424004)(13464003)(59450400001)(966005)(9686003)(86362001)(6436002)(575784001)(55016002)(14454004)(68736007)(53936002)(99286004)(6636002)(6306002)(10290500003)(66066001)(25786009)(2900100001)(10090500001)(5250100002)(107886003)(39060400002)(76176011)(22452003)(478600001)(7696005)(8990500004)(6246003)(1511001)(229853002)(2950100002)(4326008)(316002)(3660700001)(53546011)(97736004)(6506007)(2906002)(105586002)(26005)(3280700002)(186003)(102836004)(305945005)(86612001)(7736002)(6116002)(106356001)(54906003)(110136005)(33656002)(81156014)(74316002)(3846002)(8676002)(8936002)(5660300001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1108.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: NqEOGOfcZR6bI4U83PH7lKF4o2f3PYlTP+OhS+z3fJ7ijiiSYVfcRvHLRcCAFJyF6lxSSCh9mn8vTLjYsyhfgpuHGbzvaz8hF9xrc5r17TPq4Yoz/01UBqlUtBAcrW1QEdpWFM+0sAzecYUQELYiDGZt69PR4BBv7LpkqlPy2NuGUc03aw9AcLTyDHqY8C20BFF6lbFxYd0t/XdW+GY2vtl/tLcocBYWEL3ONX1wQ1tZv1JFtUqiIPJMdY72snpT8RABm99v9UkjiLbc1AWoyzgg8+dVMt911kCIP8frq6mOvuzp1NgtAkD6a8FxgNr2mqcITBY6wtMg/bg0/zmC7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31fcff0-0a67-4045-6138-08d585065f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 15:07:55.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28F886p032537

There was another report of the same issue on CoreOS, 4.14.11-coreos. The host/guest is AWS G4. So the problem is not limited to Azure VMs. It doesn't happen on older kernel like 4.4. Maybe the problem is related to some (recent) changes on fsnotify or other fs code?

Soft lockup kernel panic reboot on AWS instance on fsnotify and vfs_write  #2356
	https://github.com/coreos/bugs/issues/2356

Thanks,
- Haiyang

> -----Original Message-----
> From: Jan Kara <jack@suse.cz>
> Sent: Monday, March 5, 2018 3:49 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: linux-fsdevel@vger.kernel.org; Jan Kara <jack@suse.cz>; Amir Goldstein
> <amir73il@gmail.com>; Miklos Szeredi <mszeredi@redhat.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; 'linux-kernel@vger.kernel.org' <linux-
> kernel@vger.kernel.org>; Jork Loeser <Jork.Loeser@microsoft.com>
> Subject: Re: Any known soft lockup issue with vfs_write()->fsnotify()?
> 
> Hi!
> 
> On Fri 02-03-18 22:28:50, Dexuan Cui wrote:
> > Recently people are getting a soft lock issue with vfs_write()->fsnotify().
> > The detailed calltrace is available at:
> > https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
> >
> b.com%2Fcoreos%2Fbugs%2Fissues%2F2356&data=04%7C01%7Chaiyangz%40
> micros
> >
> oft.com%7Ca1b1bc6822c9442195ad08d582da7942%7C72f988bf86f141af91ab2
> d7cd
> >
> 011db47%7C1%7C0%7C636558797237925702%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiM
> > C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwifQ%3D%3D%7C-
> 2&sdata=pdwtsbU
> > 0%2FW3y7Zy%2BX%2Ffkbx%2FPktoKVBgimfxMyVk6Lyw%3D&reserved=0
> > https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
> >
> b.com%2Fcoreos%2Fbugs%2Fissues%2F2364&data=04%7C01%7Chaiyangz%40
> micros
> >
> oft.com%7Ca1b1bc6822c9442195ad08d582da7942%7C72f988bf86f141af91ab2
> d7cd
> >
> 011db47%7C1%7C0%7C636558797237925702%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiM
> > C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwifQ%3D%3D%7C-
> 2&sdata=w%2Bjed
> > u0yIYlpRut5sHa2%2Bhs5cdcdxp1dd3sHkyvRCPw%3D&reserved=0
> 
> I didn't see them yet.
> 
> > The kernel versions showing up the issue are:
> > 4.14.11-coreos
> > 4.14.19-coreos
> > 4.13.0-1009 -- this is the kernel with which I'm personally seeing the lockup.
> >
> > I have not got a chance to try the latest mainline kernel yet.
> 
> It would be good to try 4.15 kernel to see whether recent fixes from Miklos
> didn't fix your problem. They should be present in 4.14.11/19 kernels as well
> but one never knows...
> 
> > Before the lockup error message suddenly appears, Linux has been
> > running fine for many hours.  I have NOT found a consistent way to
> > reproduce the lockup yet.
> >
> > Looks the kernel is stuck in fsnotify(), when it tries to get the
> > fsnotify_mark_srcu lock.
> 
> It is not possible that we would 'hang' in srcu_read_lock() - that is just a read of
> one variable and increment of another. We'd have to be looping somewhere
> and watchdog would have to happen to hit us always at that place. Weird. Are
> you sure RIP points to srcu_read_lock?
> 
> > "git log fs/notify/fsnotify.c" on the latest mainline shows that some
> > recent patches might help.
> >
> > I'd like to check if this is a known issue.
> 
> As I've mentioned above, so far I didn't see reports like this...
> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
