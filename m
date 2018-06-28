Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAD0257A6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fnEHa7UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAD0257A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeF1Fu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:50:28 -0400
Received: from mail-db5eur01on0114.outbound.protection.outlook.com ([104.47.2.114]:28264
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752250AbeF1FuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU7J5V4bBjQ0vd1EPcSTCf3kDl50+eI5xpO+b7tiEgM=;
 b=fnEHa7UZPhmnvG1BtFQnV2EspxTVNJ0t4vRfZyjtIITmGA+LZSCve2M1lG11pgF+2GRKgQ8McqpgTqpd69Bp23XvNJfxjBAlHLVK10wG/KyxfPbmqOzUfSmudDXt4erMQr+x6VTb1ySWRF1Gg81xVReCYdJL+Kgm+ztbe4M2KH4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 05:50:18 +0000
Date:   Wed, 27 Jun 2018 22:50:04 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [12/24] proc: Add fs_context support to procfs [ver #7]
Message-ID: <20180628055003.GA15563@outlook.office365.com>
References: <20180626072736.GA31860@outlook.office365.com>
 <152414474815.23902.6952548431423168966.stgit@warthog.procyon.org.uk>
 <20180619033450.GA11639@outlook.office365.com>
 <20180626061320.GA12548@outlook.office365.com>
 <31831.1530003427@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <31831.1530003427@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:300:93::14) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159b8ea6-a85e-4ad5-ea48-08d5dcbb0885
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:P1CSlqiW446rrb8TcVPtJSHfH4pPz8vu+SsJUGQkf8kHn2RJawiIANgyWjMC83Q9pLAHlo7n5xZ5yHHx42SBPC6198NBnB58REYcHlej8UL5KlWVFOygREVdzTjzDxkCuiLvk41isTJBtNgMv/9bOUwcs44VRZCMujfFkZ7Gvd9MM9chmYzpZ30vadhLPaqoA4PB//WIzpR193YZHZH6i9NSv0fpKWM8fgsdhQ7C2QScHqS15dIRFHLstWYrugrx;25:ZbEfwr58CAqABIf47RvfejzOudEMWK9NeEIiOgLQpFF6Mam2kTkpkmDXQegB7Q1MPJE5xDYENyf2pxbQ8wz6zMLcNoMh1V0TED9zHp/iv60ETSbXzp0nEnbzqlyAVuN9drvDcSj0SuUktQWfhAichc4E5hthBSVLsU1eiLrWMnrzzV8EAjm2Gve+8eHKPwlzxtoKv/t6DWpNMSoQQU1S3PqIp0NgPU123Z7cdM1Jidx1daJtTohZT183W0+t2Ru36iS0bwO7MOAn6axPiwV2pcL7cbnObU9z8IzbxCWgQTI6dJlEcEIjW/vCNXUORVpfuLNxgq0m7IOENp1YfS4qwQ==;31:7KVIJDK6YRxuZd8ryIdCp+c3SsomC8C6X+AH4eGHIXfTzZyBrSc6D41M+z126C5BZ4ViVwcQuguT40Lo2x/hfCjhjbj2tKBDJBmsIUf3AaAhbwO+ktSGHsjUmRtvf9yYyTTSu0hodBwzPkcl9TVbdAaQ03UyUfOcyH0KAuimihrAEdXcKSn5sRH7mjoipP6FIKbyjujAaIf/sZL9J3F8rpfjThH7yIVqLCsFzvlzTi8=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:Sh9T9SeaYxrBoAJx0ZSjvlkkPb2dlPN7+TsKzp6SUTAbsWqqS+edxlcGA4MO5Wv5SlSsQu9iU0NfuBXKryG4T76lGtnN24sCkPCz48PQ6n58sNJq5VGLs/3kGmq7INVapcYTr1Kl8pp2K/TECPoaHSExnAcb9wbWmG6zLK05pvmHCMs3QMv7qeYUaR+2KUasa9w8s+2K15XJJmKwcjDaxn4CGZO8xGz0EemgXhqiqnVIFQvaI9SYLtgqNuwKJ1QUFDw2U4yPnKN0S+nBS3FrBGMzN981aFE/dbQ82T8OPFn98IapX4Mk0521yFmrd7Coi/FkZDcWnu+a3P3jDTYHeSk8a1G+5bJGE1qAfyOeuGA3q9NDrSS5CDV7apxo0WU+BojaF3+mRSsAkIjIFrqFW33WS/dzIW0NuOm6n8PM4awn2Wrxx88bc2/QZcqmalYRZIm3Uggxs0rK+ehRi2HZMI+gS/kvp7Z9iUc4NPADP/64w/gVDXBL21YRVtznIk4W;4:zsJYRYMIMgsnA0y6Ndtcc2abX7Pdjee4rwWxV5tEO8F+80J0tOFdCCsiecDC8CuabHvEGnBH2DoDgmi7YNr60pt31Tu8AiBauYMw/B4WMn01LePWaDkQ4v1PFY87apojDKheeoTOR2TVe+rlDMOzKUsSTKkfn0OlQThOAdCcaMPSt+ItdqbQJGWoKhdLMpbbhd59FF9wuw7MFD4MZWEpXg8gcbjc/Rb0785ClqWf1c+8gyOKOH/3NSKu8dl3aJd0J1ywt2jEx8dhW3zMLQT6DI0psRRqC5CE78erw23bSrWspPnHk8hkojrFolIO1Ld0
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255E20705C08C8F835F0C1DCF4F0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(64507834874202);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39850400004)(366004)(136003)(376002)(199004)(189003)(26005)(305945005)(7736002)(486006)(58126008)(386003)(512884003)(6506007)(16586007)(105586002)(106356001)(4326008)(5660300001)(44144004)(446003)(8936002)(476003)(86362001)(8676002)(81166006)(316002)(11346002)(956004)(81156014)(4610100001)(76176011)(2476003)(229853002)(6666003)(1076002)(93886005)(55016002)(97736004)(6916009)(6116002)(3846002)(9686003)(16526019)(186003)(68736007)(7696005)(53416004)(52116002)(568964002)(53936002)(5024004)(25786009)(478600001)(66066001)(6246003)(2906002)(84326002)(33656002)(69596002)(18370500001)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3255;23:2yJyE7eoCdbf4rNdBcnGHMYKHgcjvExQr9K0nICZ+?=
 =?us-ascii?Q?7vMBKwv/DTE05fM1p6wNSTUsJoNEEi+sxzo7nBxZk/daHiDdC1F7UXqWAl5c?=
 =?us-ascii?Q?ppvnqDM8+oF+SvzDxghiqCRlvs/a7AOJ38BkDtD8nqJ+MIydmTUkgJw4LnaO?=
 =?us-ascii?Q?GGETa9JZNIe1Y/p7RkpfbV7P4UgKUMAjLb4+Nh171ID9f8L/kCjKHdMMhLmt?=
 =?us-ascii?Q?V4hkPatRP8Mljb1c55pEv0shfrEZp0GBUqUGzLZevbMgDxiwbHl8HxbBY6zB?=
 =?us-ascii?Q?pnX8jL4lmWJ8F1NChBWoDdFCRiPDqr82MCRuwqfOWGjlWkcvYXOkTgrI3UAL?=
 =?us-ascii?Q?6EP663yBmggiwQ9cprHD38B471jSh4CSObzJQNlQrMLdRbDXFksfm9rHefF4?=
 =?us-ascii?Q?B9mGtn9a80cDXPJps3/l6RdPfd6SE51JKM0UVm0XUtS53ZdwIWq0eDGw7lIO?=
 =?us-ascii?Q?jmPeHre7MOjlLIG/1giJMhyaauNaZw+v40H8JpFs4RbJ88Cd72YrkpVBBXaG?=
 =?us-ascii?Q?EsJ3tGQBjuiyLgfR/ORZlt4IJzxaYTVBAN4kyS5FyKOkBkb6phsYteApIrCH?=
 =?us-ascii?Q?Ih2wCgYhF5gHZus9k9it4SxhpPd0ZsC9haFwlkJTntY7LbmYtkRDztloGK5q?=
 =?us-ascii?Q?jqokNjnPedcn9qAqN7A5f0wQeb0cvvN+EdQRroIvm4b1CXEBSTgWeRZLu6aR?=
 =?us-ascii?Q?KyykfmdWoeIsIhvZUpDEUxRq5t4d3Wj6NXhU08SI6GRSx46HZGzxRBTglvIC?=
 =?us-ascii?Q?Z66OqtbC4JWZMBKM5qvpc+sEF/OPnGRg2zBwtQOHVuC9supdNEPpN12r61gT?=
 =?us-ascii?Q?JYYAwSt/ka3WFdmc5SfcLAaWWTvpFMqLDbo19XRIr3EOokiV/cUYVv1SXjWj?=
 =?us-ascii?Q?WEHswkh6xatkC9jKpPHxVQhC1tkCNYXQBYFCYqfuSfuUKqF7A3sAwkroc0CR?=
 =?us-ascii?Q?3dulNo+pZ/Hq3UqYbxoAfgIGZrzG5zfJ4XolbMBKf/uxcJyl3UlODTVMctJN?=
 =?us-ascii?Q?QmkCrlA0IAdBpbOa3/kCiEsFNGcNXuakfu56EgZFaI09Uk1l7zXQqn6TjyGb?=
 =?us-ascii?Q?G4NU8zPMUzEr7IZG5gJPQjenSHclgAE0pTwpniE/dPNcPnyK6AxVXrYZJZRF?=
 =?us-ascii?Q?pGbaGn8lwo6KS6UCsrSidg+bQu5bGvaRr3KXRHYEgmSPEMK3l87KYNOUNfLL?=
 =?us-ascii?Q?UymdDizCzvo0sJK2EP/FqNSHO4ncnoXOPUwJoB1uQstkKnxNA35vtsElJqlm?=
 =?us-ascii?Q?U1yfjuNbTxtMVSN7Etr/G9J+6xBFOSUfXOT6ayhgu1pr7n7iRXyQrFeUptfg?=
 =?us-ascii?Q?mZrTyQ9TlrQ781phOGHPFTAosYC3U77ANpBARuNyJa3tO0cSODgkyrLOAWOM?=
 =?us-ascii?Q?MPtoRqoFO+Qml/7lm6M979oUEh3hWPDHJWHvFPjRdR2v/V4Bw0hrOw5HRPMK?=
 =?us-ascii?Q?AZQni5oww=3D=3D?=
X-Microsoft-Antispam-Message-Info: PscpDbmPckplqPQvRwN//MDprYd16ukN9juR1dkTbIRk8P5Pfi/8ieeUsXLtxruZuoCcuFelTtobi/MqPusDtv/NNWXpZH3wPvwWD2NvYvXOJ17AIgC9LBCChjhJAMiyiLf+ewhYZrAyNAKV4tE+qGG4vnLFIxm7mIK+7+dV3o9YnCo3NyjCP0eoRwET1S1ll+yh5pBV07oA3SzBvbT6NWnEid/+RRdzcG1OwnFyR3fEie8fiJ5z5+48/Fy4hqjUcPXn5NerB9T6c3OUNxZepGeom+PlYk15dATJKAaHVln0seCm619OcR+hcVF2gB3Y6Av3+gF58KotemBfTdC0296M/ci4Q/2GuGaIpTLXTko=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:WGfxpRH474DF9iafdJJPRLkHiBJY2Z3KvDYFaSmt5LgjGpzp7JReqxe26us29prqVmX1ZT4eCkYlt7KAT4BP/e5ntJoZa0TVORB4iY7GWpnf/ajwClpwSQb/C7HTseTlgjibNTPk1Ow7PTCbT4fS40ue+7KxW3XLdK5T4R/471re/auCwBHseFo0V0oCmvRl7Frfw8myhDAv6N0RA/PpwlGKEUWhwrmOfwYg0v5RQIbMdoBewW3fYRhj/ftwQ6o79g+U9YUwkm7zicjl1dFYUWQr5K/CN89rq2xT7ffB6Eh2OagetmOQIYbi7vGL4+pI7o3DkY00wxGxALKY2wqbdMmLYR5nPZZjtIFoJfli5evrRManmalg+lBR7AcnRX0yW/SFlQsWE3Pwl/LVhmuzI3n0X1SGfHg3U4DEry4SXHFxvbTcP2aXVBSjtsPMOoYipP2wF54lkuXVOY98dGGbug==;5:cqckSWlp2m1zY4heusAIdgQm2prRl0n+rhf2+N0pPl585tQIsvZCa4myhNxyanZmwcIR7JxhW7tnj0KC+kc782MATcI8FCipjdivpbFeMWAlN+2uRKdzMH/tc7blfP6p1JlDwpXNF50BuWYoGMW7Y4cCcASg4odJN2oR9tx3t8A=;24:ProlgunHBF/WeCRyaLhW+fCkaqupfYygc6rwinX0/mn6d7ZkUf5xOO3DcqB1pPW0RadQB19Fy2gLHTLBr0AnYvKWsMLRRWQMuv4QTw906Fw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:/Y6KwhNSfx6Gdf08G9NeIifXsbmvvBmU6YSngzSzoNPaUd+fvSJXiNxThlac+hUfxFFiPvIkbVJ5n8OFu5cz7C8frjV5uyinFuizvYjIliJinHxmJU0SRX24ZamTVFVSD0ir+Ao7B7H3qmtxLGjRmg+hVl4NhA5deKpKrFiS8AndaLmSPF5U1reyc8/tw9Q0Z2nXW+YCjVVQY8W84vCoU0/YvaCvkRNCeaWbZZ+iB440aMksmMnOqNSy8a8YNUrP;20:/SYnIK8BQSLyJldj5YScXbNLGo+TIIp1OBki0+4MAmwFwodMacr3v2YTSLvBvdPIcTM84mAilcpnMF20goL6p3AV73gJRblm1TbCTVQWgNs1Qr9vnHv0QoP4awxRHDTRFrZ9xNfWuX6nljJL4Z/vp1G2DG6fEGTTQUlvyRoQCJk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 05:50:18.7410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159b8ea6-a85e-4ad5-ea48-08d5dcbb0885
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Tue, Jun 26, 2018 at 09:57:07AM +0100, David Howells wrote:
> Andrei Vagin <avagin@virtuozzo.com> wrote:
> 
> > > > > -	mnt = kern_mount_data(&proc_fs_type, ns, 0);
> > > 
> > > Here ns->user_ns and get_current_cred()->user_ns are not always equal
> > 
> > What do you think about the attached patch?
> > ...
> > -	fc = vfs_new_fs_context(&proc_fs_type, NULL, 0,
> > -				FS_CONTEXT_FOR_KERNEL_MOUNT);
> > +	fc = vfs_new_fs_context_userns(&proc_fs_type, NULL, 0,
> > +				FS_CONTEXT_FOR_KERNEL_MOUNT, ns->user_ns);
> 
> Or you could just change fc->user_ns immediately after calling
> vfs_new_fs_context().  This is what network filesystems should do with
> fc->net_ns, for example.

Ok, it works for me. The patch is attached.

> 
> > -struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
> > +struct fs_context *vfs_new_fs_context_userns(struct file_system_type *fs_type,
> >  				      struct dentry *reference,
> >  				      unsigned int sb_flags,
> > -				      enum fs_context_purpose purpose)
> > +				      enum fs_context_purpose purpose,
> > +				      struct user_namespace *user_ns)
> 
> 
> If you'd really rather add a new parameter, please don't rename the function
> to vfs_new_fs_context_userns() - just add a new parameter.  There don't need
> to be two versions of it.
> 
> 
> This brings me to another thought:  I want to add the ability to let
> namespaces be configured by userspace, for example:

It may be a good feature, but I am not sure about procfs. A procfs
instance is created per pidns, so they should have the same owner
userns.

> 
> 	fd = fsopen("nfs");
> 	sprintf(buf, "ns user %d", my_user_ns_fd);
> 	write(fd, buf);
> 	sprintf(buf, "ns net %d", my_net_ns_fd);
> 	write(fd, buf);
> 	write(fd, "s fedoraproject.org:/pub");
> 	write(fd, "o intr");
> 	...
> 
> I think therefore, I might need to insert another phase between creating the
> context and calling the filesystem initialiser:
> 
> 	fc = vfs_new_fs_context(&afs_fs_type, mntpt, 0,
> 				FS_CONTEXT_FOR_SUBMOUNT);
> 
> followed by:
> 
> 	vfs_sb_set_namespace(fc, THIS_IS_USER_NS, user_ns);
> 	vfs_sb_set_namespace(fc, THIS_IS_NET_NS, net_ns);
> 
> but then we'd need to do:
> 
> 	vfs_begin_options(fc);
> 
> before continuing (unless we made this happen automatically on the receipt of
> the first option):
> 
> 	afs_mntpt_set_params(fc, mntpt);
> 	vfs_get_tree(fc);
> 	mnt = vfs_create_mount(fc, 0);
> 
> Alternatively, we could do the namespace setting after initialisation and let
> the fs apply the changes itself.
> 
> David

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="0001-proc-set-a-proper-user-namespace-for-fs_context.patch"

From 2297ffb333a7bcee466a5273a3fc84202b9695a6 Mon Sep 17 00:00:00 2001
From: Andrei Vagin <avagin@openvz.org>
Date: Wed, 27 Jun 2018 22:45:43 -0700
Subject: [PATCH] proc: set a proper user namespace for fs_context

A user namespace should be taken from a pidns for which a procfs is created.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
---
 fs/proc/root.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index efbdc08a3c86..59aaf06a40c7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -303,6 +303,11 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	if (fc->user_ns != ns->user_ns) {
+		put_user_ns(fc->user_ns);
+		fc->user_ns = get_user_ns(ns->user_ns);
+	}
+
 	ctx = fc->fs_private;
 	if (ctx->pid_ns != ns) {
 		put_pid_ns(ctx->pid_ns);
-- 
2.17.0


--EVF5PPMfhYS0aIcm--
