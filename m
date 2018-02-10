Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBJBmD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:42:03 -0500
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:22768 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751317AbeBJBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:41:59 -0500
From: Trond Myklebust <trondmy@primarydata.com>
To: "thiago.becker@gmail.com" <thiago.becker@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC: "bfields@fieldses.org" <bfields@fieldses.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] sunrpc: Add task's xid to 'not responding' messages on
 call_timeout
Thread-Topic: [PATCH] sunrpc: Add task's xid to 'not responding' messages on
 call_timeout
Thread-Index: AQHTogt7Yp0+W1/3xkaHrbuszyHK96Oc3I8A
Date: Sat, 10 Feb 2018 01:41:55 +0000
Message-ID: <1518226912.22856.3.camel@primarydata.com>
References: <20180210010628.19792-1-thiago.becker@gmail.com>
In-Reply-To: <20180210010628.19792-1-thiago.becker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [50.36.175.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1866;7:A60BCudFXQiSucuCHe1qK3x5Gorn+KQs+sWwW1TpXNh8wX5KZVDX+hQ4jfp3M9lz5+gY1G90e9KKAwpjWqJJ1N6QoOY+02uCwe2qT72Ow6lJEyfhQcZpOXlHhmWA+0C9AOTJ8hNuBlGeY0BLmqj0RsAAB7TLuWq10XSy83PtKY7Wyk0avOU0icdvwSxA3Hdrr4igO9jFm1c287C0sa+DT8w6dZDS15cO4Oi6ol57iAWcNxT6t1+KEdBeJ6A3+SPV;20:SjZ22DTCFbb9js91zAmbWxXM/3gQ9M+D7CRtYZDCM7Rfvank62sXhn6rlxkHM0J//1nPRzn7Xit7kz4Xm4sfRdac6rV/Y34ou/qCMC6kZl7BLInTPupSGNWSPlSrBI3n8DcAq/LFQ/orUcICHD2yZKzU0AWEuyztYZCOPw4Tcms=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 1b35bf6d-6d02-4f96-260a-08d570277797
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR11MB1866;
x-ms-traffictypediagnostic: DM5PR11MB1866:
x-microsoft-antispam-prvs: <DM5PR11MB18668132E4B9FF8441F01917BEF10@DM5PR11MB1866.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(6041288)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DM5PR11MB1866;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1866;
x-forefront-prvs: 057906460E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(346002)(39830400003)(377424004)(199004)(189003)(2950100002)(305945005)(86362001)(186003)(26005)(77096007)(66066001)(97736004)(68736007)(6246003)(106356001)(3846002)(6116002)(2501003)(2201001)(76176011)(6506007)(15650500001)(7736002)(102836004)(59450400001)(14454004)(5660300001)(103116003)(229853002)(4326008)(478600001)(3660700001)(316002)(8676002)(54906003)(110136005)(25786009)(6486002)(81156014)(3280700002)(8936002)(2906002)(39060400002)(81166006)(6512007)(99286004)(6436002)(105586002)(36756003)(2900100001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1866;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: So5B6+9brR02sygncNZgKQzCgEC1lPaM19AnZtllBttG/AEIadFAaZeQapX9A9uTdT7M1rQ5bOJjYq8ApKdsbw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <A03138769803AC41BEDC5211D4702DFF@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35bf6d-6d02-4f96-260a-08d570277797
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2018 01:41:55.3816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1866
X-MC-Unique: uN8hzAwPP5KlWoy6H2jp-Q-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1A1g97n007597

On Fri, 2018-02-09 at 23:06 -0200, Thiago Rafael Becker wrote:
> When investigating reasons for nfs failures, packet dumps arei
> eventually used.
> Finding the rpc that generated the failure is done by comparing all
> sent
> rpc calls and all received rpc replies for those which are
> unanswered,
> which is prone to errors like
> - Slow server responses
> - Incomplete and uncaptured packets in the packet dump
> - The heuristics used to inspect packets failing to interpret one
> 
> This patch adds the xid of rpc_tasks to the 'not responding' messages
> in call_timeout to make these analysis more precise.
> 
> Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
> ---
>  net/sunrpc/clnt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index e2a4184f3c5d..83c8aca951f4 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2214,9 +2214,10 @@ call_timeout(struct rpc_task *task)
>  	}
>  	if (RPC_IS_SOFT(task)) {
>  		if (clnt->cl_chatty) {
> -			printk(KERN_NOTICE "%s: server %s not
> responding, timed out\n",
> +			printk(KERN_NOTICE "%s: server %s not
> responding, timed out (xid: %x)\n",
>  				clnt->cl_program->name,
> -				task->tk_xprt->servername);
> +				task->tk_xprt->servername,
> +				be32_to_cpu(task->tk_rqstp-
> >rq_xid));
>  		}
>  		if (task->tk_flags & RPC_TASK_TIMEOUT)
>  			rpc_exit(task, -ETIMEDOUT);
> @@ -2228,9 +2229,10 @@ call_timeout(struct rpc_task *task)
>  	if (!(task->tk_flags & RPC_CALL_MAJORSEEN)) {
>  		task->tk_flags |= RPC_CALL_MAJORSEEN;
>  		if (clnt->cl_chatty) {
> -			printk(KERN_NOTICE "%s: server %s not
> responding, still trying\n",
> +			printk(KERN_NOTICE "%s: server %s not
> responding, still trying (xid: %x)\n",
>  			clnt->cl_program->name,
> -			task->tk_xprt->servername);
> +			task->tk_xprt->servername,
> +			be32_to_cpu(task->tk_rqstp->rq_xid));
>  		}
>  	}
>  	rpc_force_rebind(clnt);

NACK. We should not be logging internal information such as XIDs as
KERN_NOTICE messages. If you want this information, you can extract it
yourself; there are already plenty of ways to do so as a privileged
user.

-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
