Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDTSgv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:36:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753583AbeDTSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:36:49 -0400
From: Song Liu <songliubraving@fb.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Howard McLauchlan <hmclauchlan@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Thread-Topic: [PATCH v4] tracing: remove igrab() iput() call from uprobes.c
Thread-Index: AQHT2NK64Wn5tr/gjUWZCJg6HfV2qqQJ+VsAgAACB4A=
Date: Fri, 20 Apr 2018 18:36:38 +0000
Message-ID: <9BEE77C2-B1BE-4697-919B-06997F05A0B0@fb.com>
References: <20180420180847.418760-1-songliubraving@fb.com>
 <20180420142922.08ad9e64@gandalf.local.home>
In-Reply-To: <20180420142922.08ad9e64@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:200::6:dc3a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1705;7:JjBKD4G1QMv8bHNKrEqaht9dNBZj/I/jql78sF1rGLrFRFIUkxlx+auXX0ypMchFKqc+h0vgEZW4RN3UP/38zJ9XnctzlrXFDEQkDR/ynIrkQxNfrOm8w5cv0VFET7o2ovLL/EX5UP0OOCSymi+VqzEUh1Sn+a0FPSNF/IktxYnEjxnRbs/K1L5p32+RsM62OOzcGhJz7UJo5pxQVPqUooMCaqr633jYf2DQYOMLic1ELAkZEusggJBuLzLWbyfE;20:iyjQOKUBRMiNGc1JDotl/lb9IWyfPFkKrVoyMF2BJDsZ6VWS9U8fVrpHes0+sIsLIduPb+TotJNIm6sTbZaJ/uEAMBNBgYSbDEHZj184VRB12JRcjf00wZMUnG3zQZhqbPG6Q2BbcvkVPtkpKGZgsFx2UqiM4qwkj2atAAqWXao=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1705;
x-ms-traffictypediagnostic: DM5PR15MB1705:
x-microsoft-antispam-prvs: <DM5PR15MB1705185261B1DD7039C51F16B3B40@DM5PR15MB1705.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(11241501184)(944501397)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1705;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1705;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(50226002)(5660300001)(25786009)(83716003)(2906002)(5250100002)(7736002)(4326008)(3660700001)(6916009)(2616005)(11346002)(476003)(6116002)(86362001)(446003)(36756003)(46003)(229853002)(8936002)(316002)(6486002)(53936002)(478600001)(33656002)(57306001)(54906003)(8676002)(186003)(102836004)(2900100001)(81166006)(3280700002)(305945005)(6246003)(76176011)(6436002)(6506007)(53546011)(82746002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1705;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: kDJ2aEPtVcIz9lBcoDzOu0Nwq8nzxdzVXMUa9K5OFJLjTYEVdbrXTLY3PWzzhVBlk2zCzljK7JHASuTtA29TvzAgLFA/sQJ8RjGLvVg64u4PF8AQjr7BDsiDgig6m7CHzKl+6UI3Ru5Y7kDnRZlwpOabTbuJD7SqF8WvcdiEWW7NTHjEHKHD158X++WWWpYc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C917A549FAFA78449A52C76F274FD525@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b6ad0a95-49e4-4e32-1280-08d5a6eda76c
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ad0a95-49e4-4e32-1280-08d5a6eda76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:36:38.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1705
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3KIau3V011851



> On Apr 20, 2018, at 11:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> On Fri, 20 Apr 2018 11:08:47 -0700
> Song Liu <songliubraving@fb.com> wrote:
> 
>> For uprobes.c sisde, igrab() is not necessary. So we removed it and
> 
> You don't need to send another patch, but what is the above sentence
> suppose to say?
> 
> -- Steve
> 

Sorry for the typo. I meant "For uprobes.c side". Or "it is not necessary
to call igrab() in uprobe_register(), as the caller is required to keep
the inode reference. 

Song


>> added comments on requirements to callers of uprobe_register().
