Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeDTSt4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:49:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752599AbeDTStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:49:51 -0400
From: Song Liu <songliubraving@fb.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Thread-Topic: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Thread-Index: AQHT2NK64Wn5tr/gjUWZCJg6HfV2qqQJ+VsAgAACB4CAAAExgIAAAnOA
Date: Fri, 20 Apr 2018 18:49:40 +0000
Message-ID: <45E2FF15-D82B-43AA-ADF4-0B440A87D12C@fb.com>
References: <20180420180847.418760-1-songliubraving@fb.com>
 <20180420142922.08ad9e64@gandalf.local.home>
 <9BEE77C2-B1BE-4697-919B-06997F05A0B0@fb.com>
 <20180420144053.1e2b8396@gandalf.local.home>
In-Reply-To: <20180420144053.1e2b8396@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:200::6:dc3a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1946;7:PCxM24pmZhI0vok/cAzOQIM4vT/gevhtIaN4DQ/hTkNZ1dldWIyw8isfl7enuC2uqeuuZEA2H2/kzPOwmq64u4jysrAqG03yJq1AJD6oVIiFgbDtO4yZT9kpXblkZqLAsb+xZWVp2pUP4dSk78MKGT65vYU8KFes5FUOMk9+Ect8oLdDjEmDeNsQjREgoMZPzrtXNBBXNBaDTBV7lqTHuWNQGdtbEoKypoWR/E2n5DKrbB39LrdtRWxBxu2KIHEx;20:Eru0k8b0SdOldJppTOCVek9i8YnHR/h5Wr8wcd+8BRgFCMZPIoqVv3sdU+P2Lyl+pTRoqkz0vVcl1ydm7yp18qxK97A2bBe3KGG3VeAHRibCPohFnYl2QRdosuraUL7LKfRdur5y/JqZEidfvBL/OCHpQGOJWmQiOP3xu3p2lXo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1946;
x-ms-traffictypediagnostic: DM5PR15MB1946:
x-microsoft-antispam-prvs: <DM5PR15MB1946E054BA9193D4B616C975B3B40@DM5PR15MB1946.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(11241501184)(944501397)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1946;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1946;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(396003)(346002)(376002)(8936002)(53936002)(59450400001)(86362001)(102836004)(53546011)(93886005)(2900100001)(476003)(83716003)(57306001)(11346002)(6486002)(6246003)(76176011)(6506007)(478600001)(6512007)(25786009)(446003)(2616005)(5660300001)(4326008)(7736002)(316002)(5250100002)(50226002)(3660700001)(46003)(36756003)(3280700002)(6916009)(8676002)(305945005)(6116002)(33656002)(229853002)(2906002)(6436002)(82746002)(54906003)(186003)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1946;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 3QDEfpMQuwUMLN54DL8doeZ+p/RN4VjYe8u9xzbZz+VhzknPohh24btnpPzp4BCVEhPuyicBQ7YCyIviaaiSLob5DmrR9DX89jOF+87AtoksaQUvkjgvI7swX6fxj1VGn5J9SUoJPu+Hhk4TzpsulxXQ1axJy84m/D9jNutWEAnzNxNMw3n6f9KPCCEt+D9F
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00839FDB3EB1054ABDF0882DDE284E52@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e7c07439-0fd4-4f78-4600-08d5a6ef7956
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c07439-0fd4-4f78-4600-08d5a6ef7956
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:49:40.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1946
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3KIo2VA015267



> On Apr 20, 2018, at 11:40 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Fri, 20 Apr 2018 18:36:38 +0000
> Song Liu <songliubraving@fb.com> wrote:
> 
>>> On Apr 20, 2018, at 11:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>>> 
>>> On Fri, 20 Apr 2018 11:08:47 -0700
>>> Song Liu <songliubraving@fb.com> wrote:
>>> 
>>>> For uprobes.c sisde, igrab() is not necessary. So we removed it and  
>>> 
>>> You don't need to send another patch, but what is the above sentence
>>> suppose to say?
>>> 
>>> -- Steve
>>> 
>> 
>> Sorry for the typo. I meant "For uprobes.c side". Or "it is not necessary
>> to call igrab() in uprobe_register(), as the caller is required to keep
>> the inode reference. 
>> 
> 
> I'll update it to:
> 
> "For uprobes.c, it is not necessary to call igrab() in
> uprobe_register(), as the caller is required to keep the inode
> reference. The igrab() is removed and comments on this requirement is
> added to uprobe_register()."
> 
> -- Steve


Looks good!

Thanks,
Song
