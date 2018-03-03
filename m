Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120610-2-11924056620173868411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120610; b=u9M0yQBnzZx4YFjX1YLTiZpOC7a0BIHuA6XvMl7Ahb8n4SB
    iSEODZ3yQcxhnTihfZxGUay4Y1af7/XpediLGg40MXCbTEnWRazm5WCQtbungqe5
    RA6AYtuekhwwxhBtbFMLRf8+ZoD8+SysXms8emByUhqsInYwtrahV6az+aNd4MHN
    TnOxomGArIFuo5VEOeCA5bwkXfM/XnUvU4HVRZlVQUgS8a9thFilhLSJzH/p++yw
    voxeb3HpQDnSvsXb/k3JYwQb7yC+v3DDpCxEPgLGSDnV1VE8S8hIPtI7pA13Povo
    137UjBw2dIiYXpTvQpiMCHk6btBobteP2Gdyiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120610; bh=coG9Be
    jqQHubiXwUxNfIpkJi4tYnNQPeYsWBuEDaYQQ=; b=p8N4mh12sp3vXa0IZjA//N
    k/Y6HobJnKB8oOj1OiFOKkSYcJWX5tEwVhWpCM80SDYlwYAHGoW489gZMO/d1A8U
    lzc+Eon3SAsO/D3EvIUu5yzlCPs++4Mzq0KaHGPalOsk/yKIExMw9NE00nyDIBTH
    s/QbWFb20k01ErI8d4kMKpIp218Kj90eZQMhxwRyzShIUiNcz6bkBX6QLzBv0ASS
    J/Tpc6bBw5s+jK02fHIjKVrBA6VmN5cPIwB2u4Z52aqNPJIBcVDL1FJqOmqJrSu8
    KXDx35mmU9eua5kiz8NU1oTxqulMiTrT0GS0X11n8CgiOV7NOPWPX6SxZo6Zmqbw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mh+4nD7n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mh+4nD7n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeCCXnO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:43:14 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933693AbeCCWeo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Johansen <john.johansen@canonical.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 122/219] apparmor: Make path_max parameter
 readonly
Thread-Topic: [PATCH AUTOSEL for 4.9 122/219] apparmor: Make path_max
 parameter readonly
Thread-Index: AQHTsz8KBHKSUYg5G06TXla+z3T5Xw==
Date: Sat, 3 Mar 2018 22:29:06 +0000
Message-ID: <20180303222716.26640-122-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:K4la8aq7jONc+yh0uJhpERaC+qo7wCwufUDYzeu7bi5lE5PuSJ2i8qyS2HPp9Iy5ZYrvQ9t3S0WRjnkeVoq/JUX/YdXUDapqFZmGNsPMXovrqBT3yQMhw4KFqt+zMkMCuQlEpMtHt9KdPAJ+J3W4sd6OkkU65vBLXXaQH5sCZrWYJpa5Tbs6RHbQN6iZJqkxXFno1Rqc793S+Rm62eb49ZJ1/+RMy24GIzS18+Fd6//juCzawWCyThLY3CLHfV/q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7a77f50-52c2-4282-10de-08d58156f525
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068D0559BF143D089379A88FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(274141268393343)(89211679590171)(192374486261705)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: doC42WEb6Qn7jMmi0LLNfqdQsyKD8QXjeaOqIhRBGwtTsBB3ZMCSu483Ze6w1ETeZcMLOIAwMPuDiZ/ieEP+/vYt9eYpe9+C8czLlnM/hCTARsec0dFpUHBZH+ZPpen9XahB9lxgckWCPe56GAq7MNUO+gtKAAi8/RqYyu06v3c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a77f50-52c2-4282-10de-08d58156f525
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:06.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 622f6e3265707ebf02ba776ac6e68003bcc31213 ]

The path_max parameter determines the max size of buffers allocated
but it should  not be setable at run time. If can be used to cause an
oops

root@ubuntu:~# echo 16777216 > /sys/module/apparmor/parameters/path_max
root@ubuntu:~# cat /sys/module/apparmor/parameters/path_max
Killed

[  122.141911] BUG: unable to handle kernel paging request at ffff880080945=
fff
[  122.143497] IP: [<ffffffff81228844>] d_absolute_path+0x44/0xa0
[  122.144742] PGD 220c067 PUD 0
[  122.145453] Oops: 0002 [#1] SMP
[  122.146204] Modules linked in: vmw_vsock_vmci_transport vsock ppdev vmw_=
balloon snd_ens1371 btusb snd_ac97_codec gameport snd_rawmidi btrtl snd_seq=
_device ac97_bus btbcm btintel snd_pcm input_leds bluetooth snd_timer snd j=
oydev soundcore serio_raw coretemp shpchp nfit parport_pc i2c_piix4 8250_fi=
ntek vmw_vmci parport mac_hid ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_c=
ore ib_addr iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 bt=
rfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_=
tx xor raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid h=
id crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64=
 lrw gf128mul glue_helper ablk_helper cryptd vmwgfx psmouse mptspi ttm mpts=
csih drm_kms_helper mptbase syscopyarea scsi_transport_spi sysfillrect
[  122.163365]  ahci sysimgblt e1000 fb_sys_fops libahci drm pata_acpi fjes
[  122.164747] CPU: 3 PID: 1501 Comm: bash Not tainted 4.4.0-59-generic #80=
-Ubuntu
[  122.166250] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop Reference Platform, BIOS 6.00 07/02/2015
[  122.168611] task: ffff88003496aa00 ti: ffff880076474000 task.ti: ffff880=
076474000
[  122.170018] RIP: 0010:[<ffffffff81228844>]  [<ffffffff81228844>] d_absol=
ute_path+0x44/0xa0
[  122.171525] RSP: 0018:ffff880076477b90  EFLAGS: 00010206
[  122.172462] RAX: ffff880080945fff RBX: 0000000000000000 RCX: 00000000010=
00000
[  122.173709] RDX: 0000000000ffffff RSI: ffff880080946000 RDI: ffff8800348=
a1010
[  122.174978] RBP: ffff880076477bb8 R08: ffff880076477c80 R09: 00000000000=
00000
[  122.176227] R10: 00007ffffffff000 R11: ffff88007f946000 R12: ffff88007f9=
46000
[  122.177496] R13: ffff880076477c80 R14: ffff8800348a1010 R15: ffff8800348=
a2400
[  122.178745] FS:  00007fd459eb4700(0000) GS:ffff88007b6c0000(0000) knlGS:=
0000000000000000
[  122.180176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.181186] CR2: ffff880080945fff CR3: 0000000073422000 CR4: 00000000001=
406e0
[  122.182469] Stack:
[  122.182843]  00ffffff00000001 ffff880080946000 0000000000000000 00000000=
00000000
[  122.184409]  00000000570f789c ffff880076477c30 ffffffff81385671 ffff8800=
7a2e7a58
[  122.185810]  0000000000000000 ffff880076477c88 01000000008a1000 00000000=
00000000
[  122.187231] Call Trace:
[  122.187680]  [<ffffffff81385671>] aa_path_name+0x81/0x370
[  122.188637]  [<ffffffff813875dd>] profile_transition+0xbd/0xb80
[  122.190181]  [<ffffffff811af9bc>] ? zone_statistics+0x7c/0xa0
[  122.191674]  [<ffffffff81389b20>] apparmor_bprm_set_creds+0x9b0/0xac0
[  122.193288]  [<ffffffff812e1971>] ? ext4_xattr_get+0x81/0x220
[  122.194793]  [<ffffffff812e800c>] ? ext4_xattr_security_get+0x1c/0x30
[  122.196392]  [<ffffffff813449b9>] ? get_vfs_caps_from_disk+0x69/0x110
[  122.198004]  [<ffffffff81232d4f>] ? mnt_may_suid+0x3f/0x50
[  122.199737]  [<ffffffff81344b03>] ? cap_bprm_set_creds+0xa3/0x600
[  122.201377]  [<ffffffff81346e53>] security_bprm_set_creds+0x33/0x50
[  122.203024]  [<ffffffff81214ce5>] prepare_binprm+0x85/0x190
[  122.204515]  [<ffffffff81216545>] do_execveat_common.isra.33+0x485/0x710
[  122.206200]  [<ffffffff81216a6a>] SyS_execve+0x3a/0x50
[  122.207615]  [<ffffffff81838795>] stub_execve+0x5/0x5
[  122.208978]  [<ffffffff818384f2>] ? entry_SYSCALL_64_fastpath+0x16/0x71
[  122.210615] Code: f8 31 c0 48 63 c2 83 ea 01 48 c7 45 e8 00 00 00 00 48 =
01 c6 85 d2 48 c7 45 f0 00 00 00 00 48 89 75 e0 89 55 dc 78 0c 48 8d 46 ff =
<c6> 46 ff 00 48 89 45 e0 48 8d 55 e0 48 8d 4d dc 48 8d 75 e8 e8
[  122.217320] RIP  [<ffffffff81228844>] d_absolute_path+0x44/0xa0
[  122.218860]  RSP <ffff880076477b90>
[  122.219919] CR2: ffff880080945fff
[  122.220936] ---[ end trace 506cdbd85eb6c55e ]---

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7d3a98b2d55a..02cc952b86aa 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -707,7 +707,7 @@ module_param_named(logsyscall, aa_g_logsyscall, aabool,=
 S_IRUSR | S_IWUSR);
=20
 /* Maximum pathname length before accesses will start getting rejected */
 unsigned int aa_g_path_max =3D 2 * PATH_MAX;
-module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR | S_IWUSR);
+module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
=20
 /* Determines how paranoid loading of policy is and how much verification
  * on the loaded policy is done.
--=20
2.14.1
