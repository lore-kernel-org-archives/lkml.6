Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeDSQh1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:37:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53826 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754043AbeDSQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:37:25 -0400
From: Song Liu <songliubraving@fb.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: LKML <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        "Howard McLauchlan" <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Topic: [PATCH v2] tracing: fix bad use of igrab in trace_uprobe.c
Thread-Index: AQHT1zxd/hOH+TsgmUiWuxUvrApKJqQHypiAgABgrQCAAB+SAA==
Date: Thu, 19 Apr 2018 16:37:08 +0000
Message-ID: <F7C1033B-A155-4DA9-A686-AD39BA4CCC03@fb.com>
References: <20180418174014.1592871-1-songliubraving@fb.com>
 <CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com>
 <CAELBmZBvt=9p8muDsRucR_06kmia9vKT6CMfZbHjQL97N4aFag@mail.gmail.com>
In-Reply-To: <CAELBmZBvt=9p8muDsRucR_06kmia9vKT6CMfZbHjQL97N4aFag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
authentication-results: szeredi.hu; dkim=none (message not signed)
 header.d=none;szeredi.hu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:200::5:56a2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1547;7:Re5FSeLYqlAnqTmuNiElRlxYTk9oflgfiBK0DHYThI6HR33S8ntw+WE6Ppe1PtbdgoAKFIuwYUcPBccJlfWGBV3l7bF80lehpHSKycpV1MBOHRXGKekNohYOwP9sufEivwdVoWH/i4Wnyz9AyJB3MJlG8riBAwrHjS0szHIT/9CjbPqzY3Ade3IPnguRM6hAXpjk8pbcZ4XxmD86FCTuX9jzjL61t7aVoYijTH7FrZoifCqhnXaAxK8hSmZcbbMs;20:Y5nIHtgdAjX3gi35HiE2LC9KE24DZL97zvxCIXxkNyFMaEP9fDVC7yIGLvnKdZqdWGbi7yySCXlzr7JtavuC+kymxbqBPhKs55BU4dWPP54LofSQfw0U9jFVqv+d/KPfI5b6EeLnblh8qbW4lsUxUFoDrGfoUGItawZiz8hjaQc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1547;
x-ms-traffictypediagnostic: DM5PR15MB1547:
x-microsoft-antispam-prvs: <DM5PR15MB1547BA06D1DB7558DD6DE546B3B50@DM5PR15MB1547.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(11241501184)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR15MB1547;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1547;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(57704003)(2616005)(11346002)(5250100002)(305945005)(8676002)(81166006)(33656002)(50226002)(46003)(8936002)(7736002)(57306001)(6512007)(478600001)(6506007)(53546011)(54906003)(316002)(2900100001)(59450400001)(6486002)(76176011)(6436002)(229853002)(82746002)(6246003)(186003)(102836004)(36756003)(446003)(53936002)(6916009)(6116002)(25786009)(5660300001)(86362001)(3660700001)(575784001)(476003)(4326008)(83716003)(3280700002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1547;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 48yo3I6R0bLZxv5+MHm6RDm8UclaNdAqAo8m5l4SinTPi/OK0Da5wB1RYRi1+a56uwaf8KuZdZnxytBYopnoBxsfs3T7MnrWUzxdksWW45B81jDD0I0lcv5con2qO+mOhnEFauBXo+jbT5zSzh/YCFyxWFuZURJJjrLpuP2QR/OmWQqKna5n5zF6GsrRDW36
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A8CB80C42C3244A8CD8B3DBD972B37F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cfd8bfd8-d914-48b9-8c5f-08d5a613cb45
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd8bfd8-d914-48b9-8c5f-08d5a613cb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 16:37:08.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1547
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JGbTPi012749



> On Apr 19, 2018, at 7:44 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> On Thu, Apr 19, 2018 at 10:58 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> On Wed, Apr 18, 2018 at 7:40 PM, Song Liu <songliubraving@fb.com> wrote:
>>> As Miklos reported and suggested:
>>> 
>>>  This pattern repeats two times in trace_uprobe.c and in
>>>  kernel/events/core.c as well:
>>> 
>>>      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>>>      if (ret)
>>>          goto fail_address_parse;
>>> 
>>>      inode = igrab(d_inode(path.dentry));
>>>      path_put(&path);
>>> 
>>>  And it's wrong.  You can only hold a reference to the inode if you
>>>  have an active ref to the superblock as well (which is normally
>>>  through path.mnt) or holding s_umount.
>>> 
>>>  This way unmounting the containing filesystem while the tracepoint is
>>>  active will give you the "VFS: Busy inodes after unmount..." message
>>>  and a crash when the inode is finally put.
>>> 
>>>  Solution: store path instead of inode.
>>> 
>>> This patch fixes two instances in trace_uprobe.c.
>>> 
>>> Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
>>> Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Howard McLauchlan <hmclauchlan@fb.com>
>>> Cc: Josef Bacik <jbacik@fb.com>
>>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>>> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>> ---
>>> kernel/trace/trace_uprobe.c | 49 +++++++++++++++------------------------------
>>> 1 file changed, 16 insertions(+), 33 deletions(-)
>>> 
>>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>>> index 34fd0e0..d9ee522c 100644
>>> --- a/kernel/trace/trace_uprobe.c
>>> +++ b/kernel/trace/trace_uprobe.c
>>> @@ -55,7 +55,7 @@ struct trace_uprobe {
>>>        struct list_head                list;
>>>        struct trace_uprobe_filter      filter;
>>>        struct uprobe_consumer          consumer;
>>> -       struct inode                    *inode;
>>> +       struct path                     path;
>>>        char                            *filename;
>>>        unsigned long                   offset;
>>>        unsigned long                   nhit;
>>> @@ -289,7 +289,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
>>>        for (i = 0; i < tu->tp.nr_args; i++)
>>>                traceprobe_free_probe_arg(&tu->tp.args[i]);
>>> 
>>> -       iput(tu->inode);
>>> +       path_put(&tu->path);
>>>        kfree(tu->tp.call.class->system);
>>>        kfree(tu->tp.call.name);
>>>        kfree(tu->filename);
>>> @@ -363,7 +363,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>>> static int create_trace_uprobe(int argc, char **argv)
>>> {
>>>        struct trace_uprobe *tu;
>>> -       struct inode *inode;
>>>        char *arg, *event, *group, *filename;
>>>        char buf[MAX_EVENT_NAME_LEN];
>>>        struct path path;
>>> @@ -371,7 +370,6 @@ static int create_trace_uprobe(int argc, char **argv)
>>>        bool is_delete, is_return;
>>>        int i, ret;
>>> 
>>> -       inode = NULL;
>>>        ret = 0;
>>>        is_delete = false;
>>>        is_return = false;
>>> @@ -437,24 +435,14 @@ static int create_trace_uprobe(int argc, char **argv)
>>>        }
>>>        /* Find the last occurrence, in case the path contains ':' too. */
>>>        arg = strrchr(argv[1], ':');
>>> -       if (!arg) {
>>> -               ret = -EINVAL;
>>> -               goto fail_address_parse;
>>> -       }
>>> +       if (!arg)
>>> +               return -EINVAL;
>>> 
>>>        *arg++ = '\0';
>>>        filename = argv[1];
>>>        ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>>>        if (ret)
>>> -               goto fail_address_parse;
>>> -
>>> -       inode = igrab(d_real_inode(path.dentry));
> 
> Also, where has the d_real_inode() gone?
> 
> Looks like we need tu->inode back, since the return value of
> d_real_inode() may change over time.   I'd do the "tu->inode =
> d_real_inode(tu->path.dentry)" just before first use (i.e. when
> enabling the tracepoint).
> 
> Thanks,
> Miklos
> 

Do we need mechanism to prevent the return value of d_real_inode()
to change? Would the following sequence happen?

    create trace_uprobe
    enable trace_uprobe (uprobe_register)
    d_real changes
    disable trace_uprobe (uprobe_unregister get wrong inode?)
 
Another case might be:

    create trace_uprobe
    enable trace_uprobe (uprobe_register)
    disable trace_uprobe (uprobe_unregister)
    d_real changes
    enable trace_uprobe (do we need new inode for uprobe_register)

Thanks,
Song

> 
>>> -       path_put(&path);
>>> -
>>> -       if (!inode || !S_ISREG(inode->i_mode)) {
>> 
>> Where has the S_ISREG check gone?
>> 
>>> -               ret = -EINVAL;
>>> -               goto fail_address_parse;
>>> -       }
>>> +               return ret;
>>> 
>>>        ret = kstrtoul(arg, 0, &offset);
>>>        if (ret)
>>> @@ -490,7 +478,7 @@ static int create_trace_uprobe(int argc, char **argv)
>>>                goto fail_address_parse;
>>>        }
>>>        tu->offset = offset;
>>> -       tu->inode = inode;
>>> +       tu->path = path;
>>>        tu->filename = kstrdup(filename, GFP_KERNEL);
>>> 
>>>        if (!tu->filename) {
>>> @@ -558,7 +546,7 @@ static int create_trace_uprobe(int argc, char **argv)
>>>        return ret;
>>> 
>>> fail_address_parse:
>>> -       iput(inode);
>>> +       path_put(&path);
>>> 
>>>        pr_info("Failed to parse address or file.\n");
>>> 
>>> @@ -922,7 +910,8 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>>>                goto err_flags;
>>> 
>>>        tu->consumer.filter = filter;
>>> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>>> +       ret = uprobe_register(d_inode(tu->path.dentry), tu->offset,
>>> +                             &tu->consumer);
>>>        if (ret)
>>>                goto err_buffer;
>>> 
>>> @@ -966,7 +955,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
>>> 
>>>        WARN_ON(!uprobe_filter_is_empty(&tu->filter));
>>> 
>>> -       uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>>> +       uprobe_unregister(d_inode(tu->path.dentry), tu->offset, &tu->consumer);
>>>        tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
>>> 
>>>        uprobe_buffer_disable();
>>> @@ -1041,7 +1030,8 @@ static int uprobe_perf_close(struct trace_uprobe *tu, struct perf_event *event)
>>>        write_unlock(&tu->filter.rwlock);
>>> 
>>>        if (!done)
>>> -               return uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
>>> +               return uprobe_apply(d_inode(tu->path.dentry), tu->offset,
>>> +                                   &tu->consumer, false);
>>> 
>>>        return 0;
>>> }
>>> @@ -1073,7 +1063,8 @@ static int uprobe_perf_open(struct trace_uprobe *tu, struct perf_event *event)
>>> 
>>>        err = 0;
>>>        if (!done) {
>>> -               err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
>>> +               err = uprobe_apply(d_inode(tu->path.dentry),
>>> +                                  tu->offset, &tu->consumer, true);
>>>                if (err)
>>>                        uprobe_perf_close(tu, event);
>>>        }
>>> @@ -1337,7 +1328,6 @@ struct trace_event_call *
>>> create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>>> {
>>>        struct trace_uprobe *tu;
>>> -       struct inode *inode;
>>>        struct path path;
>>>        int ret;
>>> 
>>> @@ -1345,14 +1335,6 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
>>>        if (ret)
>>>                return ERR_PTR(ret);
>>> 
>>> -       inode = igrab(d_inode(path.dentry));
>>> -       path_put(&path);
>>> -
>>> -       if (!inode || !S_ISREG(inode->i_mode)) {
>> 
>> And here, again.
>> 
>> Otherwise ACK.
>> 
>> Also please create a separate patch that removes igrab/iput calls from
>> kernel/events/uprobes.c and adds a comment to the effect that the
>> caller is required to keep the inode (and the containing mount)
>> referenced.
>> 
>> Thanks,
>> Miklos
