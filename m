Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030618AbeEYVyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:54:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030394AbeEYVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:54:37 -0400
From: Song Liu <songliubraving@fb.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, Martin Lau <kafai@fb.com>,
        Chenbo Feng <fengc@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, net-next 2/2] bpf: avoid -Wmaybe-uninitialized warning
Thread-Topic: [PATCH, net-next 2/2] bpf: avoid -Wmaybe-uninitialized warning
Thread-Index: AQHT9HAwmV7gBmqT/UaT5SYlaUzmvaRA/OmA
Date: Fri, 25 May 2018 21:54:04 +0000
Message-ID: <1E0F5F01-EB03-4717-95E4-41944690B3E9@fb.com>
References: <20180525213331.2115471-1-arnd@arndb.de>
 <20180525213331.2115471-2-arnd@arndb.de>
In-Reply-To: <20180525213331.2115471-2-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::7:1409]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1421;7:F8U72FIEFAj0Ui4xAx8MyMFocCIUVfRV2KRDV/WfK9MWew2NkQn6KJSP7RwJzKnmtL74lzmVdH+ljoH+blSk8hJAtcFCXwS27O6lRPj4CMJH99P+lH3LXFnQqilpm45HBPDytOvoTyxzUn6rN7gv8HikL8yWgW9Wr33Ig/WgKOZL4LQugKwyj42/3jZGfli7drY0Nh3gHthekN6W1ihSuSA99t+Mio+hLh412npPUrYek9Fn9FVa4/cjRQJ+DG25;20:TLvw9gucronWWTLwOabbs2QLE2vSRBRqibbuhdg6wByXQLRkcCyO3Mkq9nU3aflmEXqEBSeXmNTQyQ6lY77BGZZqNuCTF+KBw/7ndaze5IEYqN0vQQ77GdSjdWlY/Gk6u7sEg08VAuBS4ocAi+liMVMyVIVqAT+hAhzNIJkhQvY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(478600001)(57306001)(14454004)(105586002)(97736004)(83716003)(7736002)(2900100001)(575784001)(305945005)(86362001)(46003)(36756003)(446003)(8936002)(5250100002)(3660700001)(3280700002)(50226002)(8676002)(81166006)(81156014)(486006)(6116002)(11346002)(476003)(2616005)(59450400001)(76176011)(186003)(99286004)(316002)(54906003)(102836004)(53546011)(6506007)(6916009)(2906002)(68736007)(82746002)(5660300001)(229853002)(33656002)(4326008)(25786009)(106356001)(6246003)(53936002)(6512007)(6486002)(39060400002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1421;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1421;
x-ms-traffictypediagnostic: MWHPR15MB1421:
x-microsoft-antispam-prvs: <MWHPR15MB14213C20C53939838D3BE9A6B3690@MWHPR15MB1421.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1421;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1421;
x-forefront-prvs: 06833C6A67
x-microsoft-antispam-message-info: qnDGcZwG+rYysNSZaYRYCz4jboV5PQMi3ked7mlgioHyTAYP4LaEhsbWMmvWI45A2udkrMG8mwcK10TGcReos6efLKk+xaYJdkEoxnUTClx9Mcn5/nhD4vO6lDOwpRogp5fayRn3n/6cq0M6knWTVB0eBbXq7DJy4rk5oiDPFOvp1l7SyYcIv1K2mDIB+nsE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACC7F4B0BA38374BA660309BBAD4EB01@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a52f191a-510b-4c66-07ba-08d5c28a08a0
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f191a-510b-4c66-07ba-08d5c28a08a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 21:54:04.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PLsnq4024663


> On May 25, 2018, at 2:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> The stack_map_get_build_id_offset() function is too long for gcc to track
> whether 'work' may or may not be initialized at the end of it, leading
> to a false-positive warning:
> 
> kernel/bpf/stackmap.c: In function 'stack_map_get_build_id_offset':
> kernel/bpf/stackmap.c:334:13: error: 'work' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This removes the 'in_nmi_ctx' flag and uses the state of that variable
> itself to see if it got initialized.
> 
> Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> kernel/bpf/stackmap.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index b59ace0f0f09..b675a3f3d141 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -285,11 +285,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> {
> 	int i;
> 	struct vm_area_struct *vma;
> -	bool in_nmi_ctx = in_nmi();
> 	bool irq_work_busy = false;
> -	struct stack_map_irq_work *work;
> +	struct stack_map_irq_work *work = NULL;
> 
> -	if (in_nmi_ctx) {
> +	if (in_nmi()) {
> 		work = this_cpu_ptr(&up_read_work);
> 		if (work->irq_work.flags & IRQ_WORK_BUSY)
> 			/* cannot queue more up_read, fallback */
> @@ -328,7 +327,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> 	}
> 
> -	if (!in_nmi_ctx) {
> +	if (!work) {
> 		up_read(&current->mm->mmap_sem);
> 	} else {
> 		work->sem = &current->mm->mmap_sem;
> -- 
> 2.9.0
> 

Acked-by: Song Liu <songliubraving@fb.com>
