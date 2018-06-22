Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2951124629
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hwrsSKRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2951124629
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeFVQ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:57:36 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:24617
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753072AbeFVQ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkiXMZa5MUzoD9vclYkSwey3xNxxZQYof+YxQw90bCA=;
 b=hwrsSKRgOTB0tNi+7YLg8XUFRQAAHxREwiZuX+9+ihGXL60tLAP9eBpvQmhOAQsAOIjWqWmTFweGdPffDyiu7NF7FuF0P15Bdq1u9Aqk76eMWW2c9tNaDNz9MvUFQXB3VBGTF/dGkqT4XinLUy6X2yTWfTSZVe12NngVqKNGen4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (4.16.175.162) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Fri, 22 Jun 2018 16:57:29 +0000
Date:   Fri, 22 Jun 2018 09:57:16 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [16/32] kernfs, sysfs, cgroup, intel_rdt: Support fs_context
 [ver #8]
Message-ID: <20180622165715.GA5361@outlook.office365.com>
References: <20180621184754.GB21326@outlook.office365.com>
 <152720682792.9073.14747437198191460035.stgit@warthog.procyon.org.uk>
 <29799.1529671936@warthog.procyon.org.uk>
 <20180622153029.GA3070@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180622153029.GA3070@outlook.office365.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:300:4b::29) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c8c36e-dd3d-4c88-0bb3-08d5d8613dec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(4534165)(4627221)(201703031133081)(201702281549075)(8990104)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:LOehpJi1g+Pgqw4LIz4BwBaFk9/lKMLptQk7VqjGGIR5fDxZtaawnyVJPa97NVlvW6Oe9KFK5EAO9/mCTfxjoOTHa71iqOcY6CmoMjy55LSN5T8LlU7wedubhprIkTIy7RA7tD7R0iRa2otNOPpkFb1SADrplkE0bFGe26F/bQYNtdaO+ooDw02ETegxVmFCfPiy/mKeeXaj6uZX4CG4lNMxW0gFMfDGFiniXLhHWM6NXcDufhRlKwsCc2lzRhNx;25:4pJTyy1yIWp9ibRp3Z4MYZTUe8iGMw64VavFCVG37tfdb8fk+36Z/4P7UX5b+oKW9wCbN5sJSVF3LpcbybzxtcsvvVHb2oDUkGV8lLk+l12svpCskpi3APlqCETmcHl2sxFsOigSgmiyBBm6tHZwVc7aKKTcEx2xb24tmQgvVgmdAIhW8RqHIAjbkLaItSnP7L+nV18LEh/+qUVGyKqv344+enugleeK56N28Br4UFNDM/TVwbjhsxZi4o/rmvNo6dWw0jTrFDapA4leaiT6HsOnqjDwXjvSIZ2rN6v7oh9ve0uMt+Rx9ByB+X7rcrCmlmPKO91zc/xsOARsZto8Sg==;31:dHG0hqN+XEHTdnAPDsfoaXmhNqVfnYsCwaYDXXX+2yADSwWT88PQtjImvzrBxnJGs94p9tZsIgATH8lITE/ltzHOsTkgfhpeDHf70XmkDmG4h7WyeltYnDIIQmWP97eoMSW6lpIHFhAtKeraI3oqXVyx1qjMQVITzteS8nuBsiPNA6inEqJxnc/ox6Kw7iCzGkExQJ/kLJPr4EI+W9VPAGTDM12AHq9JTFS9+s8u+d8=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:rq/W8JJaLBmi4VEFu+43mJlXmw/nvj9GsyFVRBiT205jDz0SosuxOrwUJvvoKZdf0pHHnuEVLnxohabpgOeHYFoz/hn+jEQRUhfzwVWUg0zcXaGIDZCjvgFvfa7wN8badCdhDqiNwNoTsY+qnAhoS/mT7H1S1TkMzysQie2SxgG5l1m5HrnGkbS79xSYfOJikhFol197L+jBGpMszDHOmvcRip0b6qHhn5U5T/hftzOKREt4wE2tUl3ijLNlYwBXCSpHT91Umulxcjr2W5D8SPk97sEzRLLwrGo8Vj9gekCdAukSUws57W6GxwRcspATZxVKnjOIO4/+6kzn9MVIKlmatk6Oh1kVGd6w3EOp+Rt7RoutD+g63Z/c4nnIYPKaGT0YyDX09mEunH4iGzxhEyAXI0mvjrcOjMT6Cxz2xT6H1xpPR4i5GDi5Av97PFoQqaec/xD4fFtT9+WjOfCZcfnb2MGXb+uLtkXzVQU1xqjhAz2OtOffUx5TPeBjoJcw;4:lo7dNgKOobW9OwAPV+96XKavg4nzMLFI5rGNf6rd2LEK3bKIOeZjtE0IvlwLGCwgjhNSbU+427NKHapVhi3rNDyE574RgB5G0kJdar76616z6llVmMfINK5ef/i96aJQ84kJA4cuaOK3KqvBk5zsJ7U/zzPKepYiXkDUh/L0pQZ4y8FGaRXpYxH2oIqPfDP/yWzwmCVI3rsN43q02YUMvPDTT5zbS+8IVGLubIx58xy6I8yvAXB5g2ZEckzENiyT6Q7KAbz0hxoZ57LtXaZh+w==
X-Microsoft-Antispam-PRVS: <AM6PR08MB325697FDF817C4B3C6C94EB7CF750@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(366004)(346002)(396003)(376002)(199004)(189003)(53416004)(81166006)(81156014)(11346002)(93886005)(956004)(86362001)(316002)(446003)(8936002)(6116002)(3846002)(476003)(97736004)(2906002)(1076002)(37156001)(106356001)(105586002)(66066001)(7736002)(8676002)(305945005)(47776003)(55016002)(23686003)(9686003)(68736007)(50466002)(478600001)(69596002)(6916009)(229853002)(16586007)(53936002)(6246003)(386003)(16526019)(76176011)(6506007)(33656002)(7696005)(52116002)(26005)(5660300001)(4326008)(486006)(25786009)(58126008)(6666003)(186003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3256;23:vFVBnc7VUxhbUzVTY9Ww0KIDRVzbeVFHhRbFvS0+Sm0?=
 =?koi8-r?Q?28CLFHyCFWSLXbwSHgh4lhdayyYDAhFsXsWhoa7qsIeNK+Ef2dNglEB2bQMDr9?=
 =?koi8-r?Q?Pffe1oKWSSDRXuNmUyWJ6mj7RTc8kclZgtSFyFTFjoIWe5MeJ5lfmwQaLVwNe6?=
 =?koi8-r?Q?J6hqduqOR5KrZLb4rN/Q8zHGZDUhwYCoCAHkOju0FkEKxVFXqfN0g3DTvJxA5d?=
 =?koi8-r?Q?x6wW0VywRL0+ZQjOoGw7cDwDQQ+CU64ufReN5PpIbiC4gtdtcGAGWNAFIWf3XA?=
 =?koi8-r?Q?yFaK8CerbH5bRSlwwWcF/17IcqCmlkbv7VBatASTEHXQt02mzE0Ve8Shjj/I0W?=
 =?koi8-r?Q?NzUYAjZ2Zikjs167CwU2ccQultaGL9E28OlHtSqnHCa01aW7sJz6Bd6ajpM3G4?=
 =?koi8-r?Q?xUZsJOSIKK4VmR6zeBav4fqJvEeV5dDUQyEmHNO3Hjm7SoWDLbb5YURKMV/68A?=
 =?koi8-r?Q?oayhv/T5v0BO/WWs2d/bAtsnkcqZ6oy5mTrmPJz7mWfDVH43E87SZdcZU96Ho7?=
 =?koi8-r?Q?48P5r2zlytiO4HikTLN+BRVx9gkzb4aQMeG73PKj59YXt7lQFc6Mn4bFZI9kzO?=
 =?koi8-r?Q?Y+YTopVjnzzVmvKOmVJEE6UOGQ3Sg2UdO5Xwv4oGcPZ74Vr4EhYoNxnqytKo+a?=
 =?koi8-r?Q?evsbhHM8keHSUqrEvUi3qb+JQHMGI0PPoFaZ9KGVHiFUBsLzuSdeS6kCu+/296?=
 =?koi8-r?Q?6+bAh3hx1RnVKuQmdxfkY3eRg5/4ojq+UbtYur5KS0haEgyA7+ZYD4sIP1SboK?=
 =?koi8-r?Q?PDClleSSwXZFkZ1aIREGUx4gnPQKJMqTBs22TJ0iGJk/WqwzWVPh8TCcPtmOQD?=
 =?koi8-r?Q?gayU5O8D4rBE73aq0mERnGShwrqRoVKXS/vWox9TsSweTppLjLR6yTfcgABzLJ?=
 =?koi8-r?Q?XwSAQI6Juca1OKxqV485Zhl8L3TB0Ta5yxqWOfS/FtP9tVc71rp09vrOfU3TL9?=
 =?koi8-r?Q?18RSyXM+9/vZf4RbWdqmPgSPEVqUwq1CIttKSrMDbse5UpgbbmfNXA3Aaaofgc?=
 =?koi8-r?Q?vk9VqvB4DqO/UlXo0JrNytQ7bAx0/gbaEoPinMmcUM0XtB1/8VS025VWiLiFq2?=
 =?koi8-r?Q?8Fm7vTULtsHc6GBoUM2ivIR+Wov/qk2zD9XhdlGpvCjW2ZIX26yI8OIBkpB1/o?=
 =?koi8-r?Q?DaY5+cmbWicdgKikdlUp1yvSWGIOPewxMcIzLVp2qh3VzGcKDys3ZfJBv3v82c?=
 =?koi8-r?Q?uii/K9HgPLE9CPgBfZYx2TxE097OhccHisi3vk6o446/GlBe0K2QokXKDifD49?=
 =?koi8-r?Q?VF/r1ziAjra0ROpuhN3ESH8O91+M6FZtnr86Kc3fO1WUX9Tn5qmz4yndcfxlT?=
X-Microsoft-Antispam-Message-Info: BPsS7HJh4d0ATMODLB9oepTs2YT1jLu/AQtrpKc9Pmd9Zu7p08D11j9L4788vCYQe5JawSqbyisu8V37SlVpynOB4rX514p10FPUPrPq4RTed28Wo4rCllX6Ivxdf4I/5JFHljSFkFg4oRgSv9/JWbwSMcytlKE7SW168n/aTpAepFaHdkrTNaS3IoB1256KtVrsLMXHiiESVr0VXTlvp/BQe1WRStjPCUDR2XWoWxmHitxbS9ZPk0CycoWUYu8gHZCr23A5XOiRyxnm7eBQQm7BNvB2CnhraFozL2UNxm0+qsMNueyBqq90OrgIiIN0niVnZtygPJ+rpJlD5swkCQ==
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:jZxrUW1LnDTmxK/Yks87ghWXjxXQrNq7lJQ6kV761tyASaAE1E8SWWpdWOIcLjPbamA/q+aop7gSz/WhHhgp8HgUHniQq7JCXb3cjzxDgDhNI4tuMHm+5WIViOdrQISeu3eR6EIPwySqWBJc+SmLOX6+9TtOPQ07txjrhCAGR788jFInImrWqb7KzwySAgowPgtn+fywW/AxuFc0U6MlXK3BvFW8oAlMNqGu+y8VuYAnvlQmx8QI2UR2jT3+u76cF6RW512DCSA1jxTswOH43nyvbRHt2KOXvpM5M3HgJ1hNQDdPtNk4R/6onTBIIk/vtaX2BD0cQ95SdH25EyCyPz2hD1SV9fxrbXgTVvkcyFSqjo68xxFJvhYOR7nunCJgTUkljfSasdfIATMXmYC9RqoqyFDqTmY76XCT0ErHBcYZyF2ioSxzjb3T8JjO4LsU78+EIutejqsmgFhWpOa3/Q==;5:POzaReL/qHk9XdhMRVQray35LxdAS3EiJBRGwalTxQprJw9ZbH/Fnds8mlSO3IYTpgCTtI/VXqzW6pDmDGryiCHxIGc9cBj6zEZO7WJYmPiQu/nbgvNszXJQ/skgDOzmcMwxwaX/HvpVDQzdiqUyXHv+kdGakrbZ4KRRwTe8fkI=;24:LkN+AuVimEoyb+oMPZ/jR6TWhvjChdGIQPpunFSptMMI9HXdBEEPB4gzuBndncMTapKSAdVE6s71cOxcyTgIvP9I1d2WsMnnxg5VLXfBPQw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;7:78wNzVPfwk++TYAyElEcZqKngeOZFGqY88ltuJXqBjgDOoiqRlNRBTj5oPGejSb2iqczdqOWY0O2nWvi7ozQ6AXmSWg71y6j6a9F2WEfCswSVkVnEj7rbarNPk0JDK1P3CQCkV4VqnM2hhljdlIVLNV2i5zUanKj95NmFlte2ykBxRRsEm9UQ+MbN3wdyFdtE7wiqenhHdmBDUUpJeO2XN85HQJGb81/virhUirtMzwuHn5bqJ5my6Mg5twj/SGp;20:yp+By/jVroSWP1hRFo5aNg/aMMbDGDLhqDt8SDH5QLQT6HfrbPFrS3CbXlPmFNGSIXRx0rz1kNVD1CIoyZceBPtaWg1N29yXPDOSyxAyOLJ8HFDQN3bSMjob8LFyzG83MI/fJvX8sGzpdzPrQQKu/P1rRc06TnqecAhCeaQKrXw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 16:57:29.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c8c36e-dd3d-4c88-0bb3-08d5d8613dec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:30:29AM -0700, Andrei Vagin wrote:
> On Fri, Jun 22, 2018 at 01:52:16PM +0100, David Howells wrote:
> > Andrei Vagin <avagin@virtuozzo.com> wrote:
> > 
> > >                 ret = 0;
> > > +               ctx->root = root;
> > >                 goto out_unlock;
> > 
> > Okay, I can see that.
> > 
> > >                 percpu_ref_reinit(&root->cgrp.self.refcnt);
> > >                 mutex_unlock(&cgroup_mutex);
> > >         }
> > > +       cgroup_get(&root->cgrp);
> > 
> > This probably needs to be conditional on ret == 0.
> 
> yes, you are right


I've read the code and I think it isn't obvious. A reference will be
released id cgroup_fs_context_free() even if ret isn't zero here.

I look at do_new_mount()

vfs_new_fs_context()
...
if (vfs_get_tree()) 
	goto out_fc;
....
out_fc:
put_fs_context(fc);
	fc->ops->free(fc);
		cgroup_fs_context_free()
			cgroup_put(&ctx->root->cgrp);

> 
> > 
> > Which version are you testing btw?  The patches in git have been fixed a
> > little from what was last posted.
> 
> I'm testing linux-next-20180621
> 
> commit 8439c34f07a3f58245e933ca2703239417288363 (tag: next-20180621,
> linux-next/master)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu Jun 21 14:09:41 2018 +1000
> 
>     Add linux-next specific files for 20180621
>     
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> > 
> > David
