Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeEHT3Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 15:29:16 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:45466
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754655AbeEHT3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 15:29:13 -0400
From: Long Li <longli@microsoft.com>
To: kbuild test robot <lkp@intel.com>, Long Li <longli@linuxonhyperv.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/7] cifs: smbd: Make upper layer decide when to destroy
 the transport
Thread-Topic: [PATCH 1/7] cifs: smbd: Make upper layer decide when to destroy
 the transport
Thread-Index: AQHT5lG/KBKyFBGhK0+UDJSEQVdKVKQlTQaAgADr3bA=
Date: Tue, 8 May 2018 19:29:11 +0000
Message-ID: <MWHPR2101MB0729FCF022C6FD9CD221BA0BCE9A0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180507222006.20781-1-longli@linuxonhyperv.com>
 <201805081127.wRLCfHId%fengguang.wu@intel.com>
In-Reply-To: <201805081127.wRLCfHId%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:e::2e0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0875;7:fueT8gCZ+FPlO6nefjwIvtVcLEJczuIWi5TprLa8fgxbVBTpKhoQeyCgfKAAtHAQDQaBkuuQ2F1MZw8nrn18A4ZkkJwSpe0AFTR5XcuUrkbzeTIDf1bpGq6RrGYDJRoO7HXO0rQORmUyV+vH69qIiHzDu3wWiPfgKxXr1EJsEfexX9MQopq1LanxTlsm+9X05YVMHODKp1h0mNbhrNda+ycqSZ+Y/FANOzkEHe4tKqwe5bovRzJCRRHQxxYddE22;20:Oc5n0IO75PoDE6UwIR5C72eTyHtGFdWUXq1681o0ckLdNd3Hs93Et8IqUlr3PZ2o4LUP2bCYFAID9RlUaUAQUk9QuU2KyFT0iKOmpTPqtuoatsp6kt6zlC6t0LrBPrQfPT7TQUqKEz6SjP07S2L0miAFUeeZzzmGF2H2rSNM8/I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:MWHPR2101MB0875;
x-ms-traffictypediagnostic: MWHPR2101MB0875:
x-microsoft-antispam-prvs: <MWHPR2101MB08758EB8E11C60BF3C4CB61ECE9A0@MWHPR2101MB0875.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(219752817060721);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR2101MB0875;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0875;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(69234005)(189003)(199004)(54906003)(6436002)(2900100001)(55016002)(7696005)(305945005)(110136005)(3280700002)(345774005)(316002)(6306002)(5890100001)(86612001)(9686003)(575784001)(2906002)(8990500004)(7736002)(14454004)(33656002)(3660700001)(6346003)(6246003)(4326008)(86362001)(68736007)(74316002)(76176011)(5250100002)(102836004)(5660300001)(11346002)(53936002)(229853002)(478600001)(486006)(476003)(6506007)(446003)(966005)(105586002)(99286004)(22452003)(10290500003)(6116002)(46003)(8936002)(186003)(106356001)(81166006)(10090500001)(8676002)(81156014)(25786009)(59450400001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0875;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com;
x-microsoft-antispam-message-info: kGilSrS4edybr74g7FrHWC4sx2VzLw9ttJSWZSqzQkpd6KP2aYdDfBX8aLSm+a2nGK1alO9lYnp4IJm6b7ioicDb17tPSUk1VvHUfUjOspfy64zO63YHvBKbUaKcFKSZA5lDWow59CsZZFNImDqTnc9igAmK+iBYdd28f+pMiV6V/VFi2YUKIeVFNgUw28Ip
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 68b63f95-9195-4685-9c37-08d5b519f9cc
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b63f95-9195-4685-9c37-08d5b519f9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 19:29:11.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0875
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48JTPFY006345

> Subject: Re: [PATCH 1/7] cifs: smbd: Make upper layer decide when to
> destroy the transport
> 
> Hi Long,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on cifs/for-next] [also build test ERROR on v4.17-rc4
> next-20180507] [if your patch is applied to the wrong git tree, please drop us
> a note to help improve the system]
> 
> url:
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub
> .com%2F0day-ci%2Flinux%2Fcommits%2FLong-Li%2Fcifs-smbd-Make-upper-
> layer-decide-when-to-destroy-the-transport%2F20180508-
> 110150&data=02%7C01%7Clongli%40microsoft.com%7C8eeef6813ee14ded2
> dcc08d5b4a4113a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636
> 613539125415461&sdata=6EzmQWCVBK9EESOC3UQwrObR9AL9W5u660M4k
> bDvoJw%3D&reserved=0
> base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
> config: i386-randconfig-x013-201818 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>    fs//cifs/connect.c: In function 'cifs_reconnect':
> >> fs//cifs/connect.c:381:16: error: passing argument 1 of
> >> 'smbd_destroy' from incompatible pointer type
> >> [-Werror=incompatible-pointer-types]
>       smbd_destroy(server);
>                    ^~~~~~

Thanks! I will send v2.

>    In file included from fs//cifs/connect.c:58:0:
>    fs//cifs/smbdirect.h:334:20: note: expected 'struct smbd_connection *' but
> argument is of type 'struct TCP_Server_Info *'
>     static inline void smbd_destroy(struct smbd_connection *info) {}
>                        ^~~~~~~~~~~~
>    fs//cifs/connect.c: In function 'clean_demultiplex_info':
>    fs//cifs/connect.c:715:16: error: passing argument 1 of 'smbd_destroy' from
> incompatible pointer type [-Werror=incompatible-pointer-types]
>       smbd_destroy(server);
>                    ^~~~~~
>    In file included from fs//cifs/connect.c:58:0:
>    fs//cifs/smbdirect.h:334:20: note: expected 'struct smbd_connection *' but
> argument is of type 'struct TCP_Server_Info *'
>     static inline void smbd_destroy(struct smbd_connection *info) {}
>                        ^~~~~~~~~~~~
>    Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
>    Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
>    Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
>    Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
>    Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:set_bit
>    Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:clear_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:test_and_set_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
>    Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
>    Cyclomatic Complexity 1
> include/uapi/linux/byteorder/little_endian.h:__le16_to_cpup
>    Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
>    Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
>    Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
>    Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
>    Cyclomatic Complexity 2 include/linux/list.h:__list_add
>    Cyclomatic Complexity 1 include/linux/list.h:list_add
>    Cyclomatic Complexity 1 include/linux/list.h:__list_del
>    Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
>    Cyclomatic Complexity 1 include/linux/list.h:list_del_init
>    Cyclomatic Complexity 1 include/linux/list.h:list_move
>    Cyclomatic Complexity 1 include/linux/list.h:list_empty
>    Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
>    Cyclomatic Complexity 1 include/linux/string.h:strnlen
>    Cyclomatic Complexity 4 include/linux/string.h:strlen
>    Cyclomatic Complexity 6 include/linux/string.h:strlcpy
>    Cyclomatic Complexity 3 include/linux/string.h:memset
>    Cyclomatic Complexity 4 include/linux/string.h:memcpy
>    Cyclomatic Complexity 2 include/linux/string.h:strcpy
>    Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
>    Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
>    Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
>    Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
>    Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_inc
>    Cyclomatic Complexity 1
> arch/x86/include/asm/atomic.h:arch_atomic_dec_and_test
>    Cyclomatic Complexity 1
> arch/x86/include/asm/atomic.h:arch_atomic_add_return
>    Cyclomatic Complexity 1
> arch/x86/include/asm/atomic.h:arch_atomic_sub_return
>    Cyclomatic Complexity 1 include/asm-generic/atomic-
> instrumented.h:atomic_read
>    Cyclomatic Complexity 1 include/asm-generic/atomic-
> instrumented.h:atomic_inc
>    Cyclomatic Complexity 1 include/asm-generic/atomic-
> instrumented.h:atomic_inc_return
>    Cyclomatic Complexity 1 include/asm-generic/atomic-
> instrumented.h:atomic_dec_return
>    Cyclomatic Complexity 1 include/asm-generic/atomic-
> instrumented.h:atomic_dec_and_test
>    Cyclomatic Complexity 5
> arch/x86/include/asm/preempt.h:__preempt_count_sub
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
>    Cyclomatic Complexity 1 include/linux/uidgid.h:__kuid_val
>    Cyclomatic Complexity 1 include/linux/uidgid.h:__kgid_val
>    Cyclomatic Complexity 1 include/linux/uidgid.h:uid_eq
>    Cyclomatic Complexity 1 include/linux/uidgid.h:gid_eq
>    Cyclomatic Complexity 1 include/linux/uidgid.h:uid_gt
>    Cyclomatic Complexity 1 include/linux/uidgid.h:uid_lt
>    Cyclomatic Complexity 1 include/linux/uidgid.h:uid_valid
>    Cyclomatic Complexity 1 include/linux/uidgid.h:gid_valid
>    Cyclomatic Complexity 1 include/linux/uidgid.h:make_kuid
>    Cyclomatic Complexity 1 include/linux/uidgid.h:make_kgid
>    Cyclomatic Complexity 1 include/linux/uidgid.h:from_kuid
>    Cyclomatic Complexity 1 include/linux/rbtree.h:rb_link_node
>    Cyclomatic Complexity 1
> include/linux/debug_locks.h:debug_check_no_locks_held
>    Cyclomatic Complexity 1 include/linux/workqueue.h:__init_work
>    Cyclomatic Complexity 1 include/linux/uio.h:iov_iter_count
>    Cyclomatic Complexity 1 include/linux/socket.h:msg_data_left
>    Cyclomatic Complexity 1 include/linux/sched.h:task_pid_nr
>    Cyclomatic Complexity 1 include/linux/sched.h:task_thread_info
>    Cyclomatic Complexity 1 include/linux/cred.h:current_user_ns
>    Cyclomatic Complexity 1 include/linux/kasan.h:kasan_kmalloc
>    Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
>    Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_trace
>    Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
>    Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
>    Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
>    Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
>    Cyclomatic Complexity 2 include/linux/ctype.h:__toupper
>    Cyclomatic Complexity 1 include/linux/utsname.h:utsname
>    Cyclomatic Complexity 1 include/net/net_namespace.h:get_net
>    Cyclomatic Complexity 1 include/net/net_namespace.h:put_net
>    Cyclomatic Complexity 1 include/net/net_namespace.h:net_eq
>    Cyclomatic Complexity 1 include/linux/module.h:__module_get
>    Cyclomatic Complexity 1 include/linux/module.h:module_put
>    Cyclomatic Complexity 1 include/keys/user-
> type.h:user_key_payload_locked
>    Cyclomatic Complexity 1 include/net/ipv6.h:ipv6_addr_equal
>    Cyclomatic Complexity 1
> include/linux/unaligned/access_ok.h:get_unaligned_le16
>    Cyclomatic Complexity 1 fs//cifs/cifspdu.h:BCC
>    Cyclomatic Complexity 1 fs//cifs/cifspdu.h:get_bcc
>    Cyclomatic Complexity 1 fs//cifs/cifsglob.h:set_credits
>    Cyclomatic Complexity 1 fs//cifs/cifsglob.h:get_next_mid
> 
> vim +/smbd_destroy +381 fs//cifs/connect.c
> 
>    312
>    313	static int ip_connect(struct TCP_Server_Info *server);
>    314	static int generic_ip_connect(struct TCP_Server_Info *server);
>    315	static void tlink_rb_insert(struct rb_root *root, struct tcon_link
> *new_tlink);
>    316	static void cifs_prune_tlinks(struct work_struct *work);
>    317	static int cifs_setup_volume_info(struct smb_vol *volume_info, char
> *mount_data,
>    318						const char *devname);
>    319
>    320	/*
>    321	 * cifs tcp session reconnection
>    322	 *
>    323	 * mark tcp session as reconnecting so temporarily locked
>    324	 * mark all smb sessions as reconnecting for tcp session
>    325	 * reconnect tcp session
>    326	 * wake up waiters on reconnection? - (not needed currently)
>    327	 */
>    328	int
>    329	cifs_reconnect(struct TCP_Server_Info *server)
>    330	{
>    331		int rc = 0;
>    332		struct list_head *tmp, *tmp2;
>    333		struct cifs_ses *ses;
>    334		struct cifs_tcon *tcon;
>    335		struct mid_q_entry *mid_entry;
>    336		struct list_head retry_list;
>    337
>    338		spin_lock(&GlobalMid_Lock);
>    339		if (server->tcpStatus == CifsExiting) {
>    340			/* the demux thread will exit normally
>    341			next time through the loop */
>    342			spin_unlock(&GlobalMid_Lock);
>    343			return rc;
>    344		} else
>    345			server->tcpStatus = CifsNeedReconnect;
>    346		spin_unlock(&GlobalMid_Lock);
>    347		server->maxBuf = 0;
>    348		server->max_read = 0;
>    349
>    350		cifs_dbg(FYI, "Reconnecting tcp session\n");
>    351
>    352		/* before reconnecting the tcp session, mark the smb
> session (uid)
>    353			and the tid bad so they are not used until
> reconnected */
>    354		cifs_dbg(FYI, "%s: marking sessions and tcons for
> reconnect\n",
>    355			 __func__);
>    356		spin_lock(&cifs_tcp_ses_lock);
>    357		list_for_each(tmp, &server->smb_ses_list) {
>    358			ses = list_entry(tmp, struct cifs_ses, smb_ses_list);
>    359			ses->need_reconnect = true;
>    360			list_for_each(tmp2, &ses->tcon_list) {
>    361				tcon = list_entry(tmp2, struct cifs_tcon,
> tcon_list);
>    362				tcon->need_reconnect = true;
>    363			}
>    364			if (ses->tcon_ipc)
>    365				ses->tcon_ipc->need_reconnect = true;
>    366		}
>    367		spin_unlock(&cifs_tcp_ses_lock);
>    368
>    369		/* do not want to be sending data on a socket we are freeing
> */
>    370		cifs_dbg(FYI, "%s: tearing down socket\n", __func__);
>    371		mutex_lock(&server->srv_mutex);
>    372		if (server->ssocket) {
>    373			cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
>    374				 server->ssocket->state, server->ssocket-
> >flags);
>    375			kernel_sock_shutdown(server->ssocket, SHUT_WR);
>    376			cifs_dbg(FYI, "Post shutdown state: 0x%x Flags:
> 0x%lx\n",
>    377				 server->ssocket->state, server->ssocket-
> >flags);
>    378			sock_release(server->ssocket);
>    379			server->ssocket = NULL;
>    380		} else if (cifs_rdma_enabled(server))
>  > 381			smbd_destroy(server);
>    382		server->sequence_number = 0;
>    383		server->session_estab = false;
>    384		kfree(server->session_key.response);
>    385		server->session_key.response = NULL;
>    386		server->session_key.len = 0;
>    387		server->lstrp = jiffies;
>    388
>    389		/* mark submitted MIDs for retry and issue callback */
>    390		INIT_LIST_HEAD(&retry_list);
>    391		cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
>    392		spin_lock(&GlobalMid_Lock);
>    393		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
>    394			mid_entry = list_entry(tmp, struct mid_q_entry,
> qhead);
>    395			if (mid_entry->mid_state ==
> MID_REQUEST_SUBMITTED)
>    396				mid_entry->mid_state =
> MID_RETRY_NEEDED;
>    397			list_move(&mid_entry->qhead, &retry_list);
>    398		}
>    399		spin_unlock(&GlobalMid_Lock);
>    400		mutex_unlock(&server->srv_mutex);
>    401
>    402		cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
>    403		list_for_each_safe(tmp, tmp2, &retry_list) {
>    404			mid_entry = list_entry(tmp, struct mid_q_entry,
> qhead);
>    405			list_del_init(&mid_entry->qhead);
>    406			mid_entry->callback(mid_entry);
>    407		}
>    408
>    409		do {
>    410			try_to_freeze();
>    411
>    412			/* we should try only the port we connected to
> before */
>    413			mutex_lock(&server->srv_mutex);
>    414			if (cifs_rdma_enabled(server))
>    415				rc = smbd_reconnect(server);
>    416			else
>    417				rc = generic_ip_connect(server);
>    418			if (rc) {
>    419				cifs_dbg(FYI, "reconnect error %d\n", rc);
>    420				mutex_unlock(&server->srv_mutex);
>    421				msleep(3000);
>    422			} else {
>    423				atomic_inc(&tcpSesReconnectCount);
>    424				spin_lock(&GlobalMid_Lock);
>    425				if (server->tcpStatus != CifsExiting)
>    426					server->tcpStatus =
> CifsNeedNegotiate;
>    427				spin_unlock(&GlobalMid_Lock);
>    428				mutex_unlock(&server->srv_mutex);
>    429			}
>    430		} while (server->tcpStatus == CifsNeedReconnect);
>    431
>    432		if (server->tcpStatus == CifsNeedNegotiate)
>    433			mod_delayed_work(cifsiod_wq, &server->echo, 0);
>    434
>    435		return rc;
>    436	}
>    437
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01
> .org%2Fpipermail%2Fkbuild-
> all&data=02%7C01%7Clongli%40microsoft.com%7C8eeef6813ee14ded2dcc08
> d5b4a4113a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63661353
> 9125415461&sdata=OrOmZ1yCHuTbOlK8c6oBG9FpUbjBcQR5nGGa%2BntzwL
> E%3D&reserved=0                   Intel Corporation
