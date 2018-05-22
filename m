Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeEVV6s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:58:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753141AbeEVV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:58:45 -0400
From: Song Liu <songliubraving@fb.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] perf/core: fix bad use of igrab in
 kernel/event/core.c
Thread-Topic: [PATCH 2/2] perf/core: fix bad use of igrab in
 kernel/event/core.c
Thread-Index: AQHT1t6nfeADCJH+rUmeeV0pDKTod6QHnlsAgDTjVAA=
Date: Tue, 22 May 2018 21:56:18 +0000
Message-ID: <7815A35E-6506-477D-8E57-3960F7C1FE62@fb.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <20180418062907.3210386-2-songliubraving@fb.com>
 <20180419061710.l6sdq3kvricpyjdu@um.fi.intel.com>
In-Reply-To: <20180419061710.l6sdq3kvricpyjdu@um.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [199.201.64.131]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1660;7:FfLlOMpGQs/R2er53kQnm3KaA2A30Udz+mxn82L8oSRbmZDwRyYB+k8HnvsvYBdbd68itnm4XbVHEJzn4UFMJYJ3KcRvTRFUvDytRqPgjVI+v5Vqf7/r2A0ErsHYMt7Q6dEB2JyckSOf2p3jGVhpjV7fpwZoaR8zeY6T3inXfoGkOM3QfV7hdR3NAZ7pF074rPM7v8dasTVHrShoCZ+mUMq8Zm275b/8Rz406TifxLKRpkTc6bPKWavAOFUICofZ;20:Kt5C3RPsXdcXkkRjZUyAOZz2VedgDcM0MF6fHcvTfCx5j32E1pzg+Fa59k2bm4lps+N52NgzdsIWaWYtMTVI/SKERAJbhIoMshDQbpTVa1zG9so/llVCw4HxuILlCmnT28lJGDuE8heyo09lO1wguqn/TEhxhVb+Y5kLa0G6L08=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1660;
x-ms-traffictypediagnostic: DM5PR15MB1660:
x-microsoft-antispam-prvs: <DM5PR15MB1660ACB53974075C85FE612DB3940@DM5PR15MB1660.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR15MB1660;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1660;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(189003)(199004)(54906003)(14454004)(83716003)(186003)(5250100002)(102836004)(82746002)(2906002)(50226002)(36756003)(8936002)(6916009)(5660300001)(305945005)(7736002)(25786009)(26005)(6506007)(105586002)(3846002)(6116002)(86362001)(6512007)(53546011)(3660700001)(97736004)(33656002)(57306001)(53936002)(6436002)(316002)(81166006)(99286004)(81156014)(478600001)(229853002)(106356001)(76176011)(486006)(2900100001)(4326008)(11346002)(3280700002)(2616005)(476003)(68736007)(6486002)(6246003)(446003)(66066001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1660;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SMyyFDRDg7+l+AmNxrnF372MBh/xruH2u8PxDPYnqvcYBrh62yL0wds4szDq4ytx4le8Ha4yW9gpkgqZ6FYXAUQUn0LAGF9pt85mBUt/LGw+R0Auz606tVq8qfNLCR40reblNZWW0KVI7CU7T02G3AtPhUpI6iZ8b4T70+km7lJFuEcmrUlQ8n/ifOKMN+Ky
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCA4146426D28D4EBC9D80E8F9B7EE5C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 65ad1c98-62ba-4e91-fecf-08d5c02ed942
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ad1c98-62ba-4e91-fecf-08d5c02ed942
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 21:56:18.7930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1660
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MLwqLN006513


> On Apr 18, 2018, at 11:17 PM, Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
> 
> On Tue, Apr 17, 2018 at 11:29:07PM -0700, Song Liu wrote:
>> As Miklos reported and suggested:
>> 
>>  This pattern repeats two times in trace_uprobe.c and in
>>  kernel/events/core.c as well:
>> 
>>      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>>      if (ret)
>>          goto fail_address_parse;
>> 
>>      inode = igrab(d_inode(path.dentry));
>>      path_put(&path);
>> 
>>  And it's wrong.  You can only hold a reference to the inode if you
>>  have an active ref to the superblock as well (which is normally
>>  through path.mnt) or holding s_umount.
> 
> Oops. I must have snatched it from the uprobe code without thinking.
> 
>>  This way unmounting the containing filesystem while the tracepoint is
>>  active will give you the "VFS: Busy inodes after unmount..." message
>>  and a crash when the inode is finally put.
>> 
>>  Solution: store path instead of inode.
>> 
>> This patch fixes the issue in kernel/event/core.c.
>> 
>> NOTE: Based on my understanding, perf_addr_filter only supports intel_pt.
> 
> Coresight too, but that's probably even further away from what you have.
> 
>> However, my test system doesn't support address filtering (or I made a
>> mistake?). Therefore, I have NOT tested this patch.
> 
> Check /sys/devices/intel_pt/caps/num_address_ranges, if it's non-zero,
> it's supported.
> 
>> Could someone please help test it?
> 
> Yes:
> 
> Reviewed-and-tested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> The subject line needs a little love to be more like other perf commits, but
> other than that, looks good.
> 
> Thanks!

Did this patch ever make into tip/perf/XX trees? If not, what shall I do 
to move it ahead?

Thanks,
Song
