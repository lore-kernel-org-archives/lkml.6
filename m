Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeDRRvE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:51:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48580 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750885AbeDRRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:51:02 -0400
From: Song Liu <songliubraving@fb.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Topic: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Index: AQHT1zxd/hOH+TsgmUiWuxUvrApKJqQGzEsAgAAAzwA=
Date: Wed, 18 Apr 2018 17:50:51 +0000
Message-ID: <DA4AAC91-34AB-4CCA-BC5E-D708F842A66E@fb.com>
References: <20180418174014.1592871-1-songliubraving@fb.com>
 <20180418134756.482c899f@gandalf.local.home>
In-Reply-To: <20180418134756.482c899f@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:180::1:db29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1836;7:9MAZrW0sEUlJj4SXnZiv9LB9FHrs7lagXs0Eh6b2oJ+11VcCU36WnRvu3dpyzze6R1TBHcGvcWAyy1bNu8+S3KZJ5OySnmqGRLzDaoGKBp9NG4CFARt3zTzXng/oyLVRwV38d9P+pmLZNAk4U4L/EHQ0ixJ3vkLkNAKzHLmrzNleWG2amtv4PUdQ/E0/5GRTNVjTFwUwYjglRowdLtZKJYULjItlUWLiLavgr0MRDpH4xctaZFaNffVX5lKTUBLm;20:4RV3zg26DX4aD1ZcuZfG+07zQ+TniiDVcb9fIJnSPsGH8p0Ln40lpn6FxtkRBRYKI315cIy3TjuXBmBx7uDMAD/wBbm7Uttw1AoOgRKm6NZl0J6uAGDVn0oDZbiTpYsRZ4bvCw+HRNaIaKVCHvQCeA/jvfI5FdRRFj8SnF5xqs8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1836;
x-ms-traffictypediagnostic: DM5PR15MB1836:
x-microsoft-antispam-prvs: <DM5PR15MB1836B72F4EFACC2408DEA1AEB3B60@DM5PR15MB1836.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(11241501184)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1836;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1836;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(39380400002)(305945005)(4326008)(8676002)(5660300001)(316002)(81166006)(8936002)(54906003)(6916009)(3280700002)(7736002)(3660700001)(6116002)(6246003)(2906002)(478600001)(5250100002)(59450400001)(11346002)(102836004)(6506007)(186003)(33656002)(76176011)(53546011)(6486002)(6436002)(6512007)(476003)(229853002)(53936002)(25786009)(57306001)(83716003)(446003)(99286004)(36756003)(82746002)(14454004)(2616005)(86362001)(575784001)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1836;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: gwg3hETboxR8EZos6iWBM7ewA99R7GpEmbK1rHgWTsvKH/MNhd5c3APGj4SdPN1Btmme0Hg4PV2z+YdzMNn33Mw+AU1meI6lnTlOXgmNvWrIYmgHaLtVkkB/qPz+HAESPbXGZhq5b0CwCbzYAcbN835sD6ZzOIuqYVXcEfuNRlsWwjD5m5sZb/Q8boRx0XJr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35925EEBDAD3B2489D3B073591090B58@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 08f3225d-931b-4ab8-c241-08d5a554ecf6
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f3225d-931b-4ab8-c241-08d5a554ecf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 17:50:51.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1836
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3IHpAww022089



> On Apr 18, 2018, at 10:47 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> You forgot to add Miklos again.
> 

I am really sorry! I was expecting "Reported-by" to add Miklos.

Song


> Miklos, have any comments on this patch? Or can you give a
> "Reviewed-by"?
> 
> -- Steve
> 
> 
> On Wed, 18 Apr 2018 10:40:14 -0700
> Song Liu <songliubraving@fb.com> wrote:
> 
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
>> 
>>  This way unmounting the containing filesystem while the tracepoint is
>>  active will give you the "VFS: Busy inodes after unmount..." message
>>  and a crash when the inode is finally put.
>> 
>>  Solution: store path instead of inode.
>> 
>> This patch fixes two instances in trace_uprobe.c.
>> 
>> Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
>> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Howard McLauchlan <hmclauchlan@fb.com>
>> Cc: Josef Bacik <jbacik@fb.com>
>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> kernel/trace/trace_uprobe.c | 49 +++++++++++++++------------------------------
>> 1 file changed, 16 insertions(+), 33 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index 34fd0e0..d9ee522c 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -55,7 +55,7 @@ struct trace_uprobe {
>> 	struct list_head		list;
>> 	struct trace_uprobe_filter	filter;
>> 	struct uprobe_consumer		consumer;
>> -	struct inode			*inode;
>> +	struct path			path;
>> 	char				*filename;
>> 	unsigned long			offset;
>> 	unsigned long			nhit;
>> @@ -289,7 +289,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>> 	for (i = 0; i < tu->tp.nr_args; i++)
>> 		traceprobe_free_probe_arg(&tu->tp.args[i]);
>> 
>> -	iput(tu->inode);
>> +	path_put(&tu->path);
>> 	kfree(tu->tp.call.class->system);
>> 	kfree(tu->tp.call.name);
>> 	kfree(tu->filename);
>> @@ -363,7 +363,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>> static int create_trace_uprobe(int argc, char **argv)
>> {
>> 	struct trace_uprobe *tu;
>> -	struct inode *inode;
>> 	char *arg, *event, *group, *filename;
>> 	char buf[MAX_EVENT_NAME_LEN];
>> 	struct path path;
>> @@ -371,7 +370,6 @@ static int create_trace_uprobe(int argc, char **argv)
>> 	bool is_delete, is_return;
>> 	int i, ret;
>> 
>> -	inode = NULL;
>> 	ret = 0;
>> 	is_delete = false;
>> 	is_return = false;
>> @@ -437,24 +435,14 @@ static int create_trace_uprobe(int argc, char **argv)
>> 	}
>> 	/* Find the last occurrence, in case the path contains ':' too. */
>> 	arg = strrchr(argv[1], ':');
>> -	if (!arg) {
>> -		ret = -EINVAL;
>> -		goto fail_address_parse;
>> -	}
>> +	if (!arg)
>> +		return -EINVAL;
>> 
>> 	*arg++ = '\0';
>> 	filename = argv[1];
>> 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>> 	if (ret)
>> -		goto fail_address_parse;
>> -
>> -	inode = igrab(d_real_inode(path.dentry));
>> -	path_put(&path);
>> -
>> -	if (!inode || !S_ISREG(inode->i_mode)) {
>> -		ret = -EINVAL;
>> -		goto fail_address_parse;
>> -	}
>> +		return ret;
>> 
>> 	ret = kstrtoul(arg, 0, &offset);
>> 	if (ret)
>> @@ -490,7 +478,7 @@ static int create_trace_uprobe(int argc, char **argv)
>> 		goto fail_address_parse;
>> 	}
>> 	tu->offset = offset;
>> -	tu->inode = inode;
>> +	tu->path = path;
>> 	tu->filename = kstrdup(filename, GFP_KERNEL);
>> 
>> 	if (!tu->filename) {
>> @@ -558,7 +546,7 @@ static int create_trace_uprobe(int argc, char **argv)
>> 	return ret;
>> 
>> fail_address_parse:
>> -	iput(inode);
>> +	path_put(&path);
>> 
>> 	pr_info("Failed to parse address or file.\n");
>> 
>> @@ -922,7 +910,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>> 		goto err_flags;
>> 
>> 	tu->consumer.filter = filter;
>> -	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>> +	ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
>> +			      &tu->consumer);
>> 	if (ret)
>> 		goto err_buffer;
>> 
>> @@ -966,7 +955,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>> 
>> 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>> 
>> -	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>> +	uprobe_unregister(d_inode(tu->path.dentry), tu->offset, &tu->consumer);
>> 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
>> 
>> 	uprobe_buffer_disable();
>> @@ -1041,7 +1030,8 @@ static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
>> 	write_unlock(&tu->filter.rwlock);
>> 
>> 	if (!done)
>> -		return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
>> +		return uprobe_apply(d_inode(tu->path.dentry), tu->offset,
>> +				    &tu->consumer, false);
>> 
>> 	return 0;
>> }
>> @@ -1073,7 +1063,8 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>> 
>> 	err = 0;
>> 	if (!done) {
>> -		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
>> +		err = uprobe_apply(d_inode(tu->path.dentry),
>> +				   tu->offset, &tu->consumer, true);
>> 		if (err)
>> 			uprobe_perf_close(tu, event);
>> 	}
>> @@ -1337,7 +1328,6 @@ struct trace_event_call *
>> create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>> {
>> 	struct trace_uprobe *tu;
>> -	struct inode *inode;
>> 	struct path path;
>> 	int ret;
>> 
>> @@ -1345,14 +1335,6 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>> 	if (ret)
>> 		return ERR_PTR(ret);
>> 
>> -	inode = igrab(d_inode(path.dentry));
>> -	path_put(&path);
>> -
>> -	if (!inode || !S_ISREG(inode->i_mode)) {
>> -		iput(inode);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
>> 	/*
>> 	 * local trace_kprobes are not added to probe_list, so they are never
>> 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
>> @@ -1364,11 +1346,12 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>> 	if (IS_ERR(tu)) {
>> 		pr_info("Failed to allocate trace_uprobe.(%d)\n",
>> 			(int)PTR_ERR(tu));
>> +		path_put(&path);
>> 		return ERR_CAST(tu);
>> 	}
>> 
>> 	tu->offset = offs;
>> -	tu->inode = inode;
>> +	tu->path = path;
>> 	tu->filename = kstrdup(name, GFP_KERNEL);
>> 	init_trace_event_call(tu, &tu->tp.call);
>> 
> 
