Return-Path: <prvs=5824d3ed3=paf@cray.com>
X-Google-Smtp-Source: AH8x227tgP5dhVl5J8yQqgauFCwsRCliLKiyyGzFEYqK4UWjlQJEvqQe77NWmLXjvm5KB60LINsh
ARC-Seal: i=1; a=rsa-sha256; t=1519100292; cv=none;
        d=google.com; s=arc-20160816;
        b=hlY/w87pAn+PAhWjUzxHj75SeehdDyjGm+QjYr8Uyl7R376z9uEhdyTZEbjAAhyKLg
         f18hm2Fwz8Pl69/IHggUCGpgXkGD8LM33/qcUu+uFVIINLEdlge+8X9/K3dblG1iZQpH
         S4jrqfDddQwI4lNO0eooILRuSWlZpuwfx2hC3ORaNaD/SuD98PJiLl3ri6r/f/Fv/gmm
         UPebePlUXtwFO/7mU5i54LsYD3kcw34Dt5hFu5zMNcdNxdGdDjSgQkrizctxSP0yfSiG
         qKpyMmJqwc5GYGXDHzECuTS7fvi45ZToSB6uZWS45TAMPTHPxOkYc/VBGRmkxknmqdub
         Gq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:dkim-signature:arc-authentication-results;
        bh=QFo1jnbzJKYjpvmFZE7HMHQyUKMqzaVjGlqGofnRhNk=;
        b=eH5/OFzWGs34xU8UTfER1bCIMBIy2PAIS0s7/VjLnQh3biJx25SWaSVa3gTQsqbZWX
         foixXaVaVsXAKrR+aSO2ncCwbn7yGTp4lPImyCurYXj7dmbpksmYfEiMAgeIcjCezYY4
         iLyF8ALwJW7dDoLbNNJmXpP6jWteW4/hwg+dU4lZC94z54Yru2RXXlDDZ4lHfLwzoiie
         OVxFSWWaBe9sGCXKjJmlVic/tyUSDiwfmTnVpYcqSsMXsbG80AjpdOFjhxZtmkOqDa+M
         rGATX5djEgxYhhtduFZwjHtcTY6qdzQMES4/9SNWdEFcpelbfeX16lj0uxs8czXQCLKg
         i5jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=b7zxsgiX;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=yfcSzpMy;
       spf=pass (google.com: domain of prvs=5824d3ed3=paf@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=5824d3ed3=paf@cray.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@cray.com header.s=cray1024 header.b=b7zxsgiX;
       dkim=pass header.i=@crayinc.onmicrosoft.com header.s=selector1-cray-com header.b=yfcSzpMy;
       spf=pass (google.com: domain of prvs=5824d3ed3=paf@cray.com designates 68.232.142.33 as permitted sender) smtp.mailfrom=prvs=5824d3ed3=paf@cray.com
X-IronPort-AV: E=Sophos;i="5.46,537,1511827200";
   d="scan'208";a="18233224"
X-Cray-OBMMKR: 1433258124 18233224
From: Patrick Farrell <paf@cray.com>
To: NeilBrown <neilb@suse.com>, Oleg Drokin <oleg.drokin@intel.com>, "James
 Simmons" <jsimmons@infradead.org>, Andreas Dilger <andreas.dilger@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: lkml <linux-kernel@vger.kernel.org>, lustre
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 00/21] staging: assorted lustre clean-up
Thread-Topic: [lustre-devel] [PATCH 00/21] staging: assorted lustre clean-up
Thread-Index: AQHTqfH1/iE52eHutUujSSL+zuhVZqOsr4xy
Date: Tue, 20 Feb 2018 04:18:07 +0000
Message-ID: <BN6PR1101MB213293D47D19B25752F4B7C9CBCF0@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <151909308778.25814.9912662268627044409.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=paf@cray.com; 
x-originating-ip: [2601:443:480:1e55:81b3:73da:8070:a8bf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2081;6:LPlSmV1TTh7iSixaAdv4AjFn/kLkFiZIbUfi5XFjPzjws7PjbdBnHH0fZReWk9m0DyaRe7DDlgwY517i+GSYY1XFiQB+6yb5v+37/VoTVMek3l/ikrTF7QLxfFqBu69TYXwT9dTyZu4TKmSQXx5VVF3XZ8s7gVJME7Pp5f+WbCZRMqbezGrcoFcDNs/d8fsEgmf/LCZNu5HKnMztubW4/gVmb2rv0YbKeqJM0QZw+1sEWL74j7I4wVxidT6d9WKy06+zy8qO7H1XOX4yEOKYLRYlumj/O7UsmHdsNSneHnZghI/cw4gvAyErmqR7/H5bSx9GWr9eX8MmmWgJqLk1MUopfgBzOzJY3naaSab7dlyFy257eFMcuFIpyEw5qEPx;5:IYfZIQFq1whDpOTqmsU12d+NXmMYcAN16tgIXsyYEszaAxsoYYQu8jD4NB9TTqVUx0n2qNc1yXQksonOcqPdKbqxwaV/4bWeGzHILcWCyMboHe+2wCJdwDCTTwSBl2G0EihDqbq+qIarPP4d9cwM6kvRmKROrao6LHojhBZIbT0=;24:3IiVVU7zJWI3OPtYQmgFvZ1y0PUU2EQ/zh3NuQLlosUWzUqCYDNGOUgONg+Sje4ZVkSPnJnS2f/H7Dq9V7KkD5VboqvF3Oj7m8Q7ErhYTQY=;7:K6H92h3rPDa//qDHGOojrV0iI4NTbTztrT0XbsJqBWNvAcg4W0DgBXsCKkbVBi6DLInbBCfA5oDINpxeTcHIYU8qHmFHCoV2iGWyfBPSSilQGo5R93PUFCHo/2MJocwuCl7hEHs2OMiePqyaRMS90zO4AbY7Aj7p27XKyPXQJo3w4uvTcrWN9IjlCwuZyj8BjoWJ5zgb/RsXk1v5QBMBZwAObrEe07pseoUOfG9Y13zEgLY1MXRU1qRimWnUewpK
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: c4d7ae8b-fe6b-4d32-25ce-08d57818f1fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6PR1101MB2081;
x-ms-traffictypediagnostic: BN6PR1101MB2081:
x-microsoft-antispam-prvs: <BN6PR1101MB2081BFB2C60EF819277015AACBCF0@BN6PR1101MB2081.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR1101MB2081;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2081;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39850400004)(366004)(346002)(189003)(199004)(33656002)(25786009)(4326008)(97736004)(54906003)(110136005)(316002)(99286004)(86362001)(105586002)(6246003)(6436002)(53936002)(55016002)(106356001)(9686003)(6306002)(2900100001)(305945005)(68736007)(3660700001)(53546011)(6506007)(14454004)(8936002)(8676002)(81156014)(81166006)(59450400001)(3280700002)(7736002)(5660300001)(2906002)(2950100002)(77096007)(186003)(478600001)(7696005)(76176011)(102836004)(74316002)(966005)(229853002)(6116002)(13693001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1101MB2081;H:BN6PR1101MB2132.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: FYmoaygJJNckEgEctPGhywxxn84ApPCaHldlBm9aob+EMV8Ogo7vTFcNVMzeMrSM1mbV6+rMJCpwTyAcSNdqMUo5K3Rc81DnakprHh5GXxfvviJdqg/rnIdd56t7WIAZMUH6oqNqzAneZSuAvr76/GZkhDVcofSpF26JC7m2hus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d7ae8b-fe6b-4d32-25ce-08d57818f1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 04:18:07.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2081
X-OriginatorOrg: cray.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592884943787540243?=
X-GMAIL-MSGID: =?utf-8?q?1592892108409528722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Lustre networking driver.  (Or so I was taught)

Regards,
Patrick


________________________________________
From: lustre-devel <lustre-devel-bounces@lists.lustre.org> on behalf of Nei=
lBrown <neilb@suse.com>
Sent: Monday, February 19, 2018 8:23:37 PM
To: Oleg Drokin; James Simmons; Andreas Dilger; Greg Kroah-Hartman
Cc: lkml; lustre
Subject: [lustre-devel] [PATCH 00/21] staging: assorted lustre clean-up

Following are assorted patches which clean up parts of lustre.
One or two tiny buglets are fixed, but mostly the patches
just make the code more readable, often by removing distractions.

The first several patches remove content from libcfs, completely
removing 3 files.
There are some list_for_each improvements in ptlrpc, and some
code simplification in fid.
Finally a small simplification in socklnd.

(lnd ?? Lustre Networking Domain??)

Thanks,
NeilBrown


---

NeilBrown (21):
      staging: lustre: replace all CFS_CAP_* macros with CAP_*
      staging: lustre: opencode cfs_cap_{raise,lower,raised}
      staging: lustre: remove linux-curproc.c
      staging: lustre: remove unnecessary cfs_block_allsigs() calls
      staging: lustre: lnet: remove cfs_block_allsigs calls.
      staging: lustre: simplify linux-prim.c
      staging: lustre: improve API and implementation of blocking signals.
      staging: lustre: make signal-blocking functions inline
      staging: lustre: discard libcfs_kvzalloc_cpt()
      staging: lustre: discard lu_buf allocation library.
      staging: lustre: improve some libcfs_kvzalloc calls.
      staging: lustre: discard libcfs_kvzalloc and linux-mem.c
      staging: lustre: remove phantom struct cfs_crypto_hash_desc
      staging: lustre: fix assorted checkpatch errors
      staging: lustre: ptlrpc: list_for_each improvements.
      staging: lustre: fid: convert lcs_mutex to a spinlock
      staging: lustre: fid: use wait_event_cmd()
      staging: lustre: fid: remove seq_fid_alloc_fini() and simplify
      staging: lustre: fid: fix up debugfs access to ->lcs_space
      staging: lustre: fid: perform sanity checks before commiting
      staging: lustre: socklnd: simplify ksnc_rx_iov_space


 .../staging/lustre/include/linux/libcfs/curproc.h  |   37 ++-----
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   27 +++--
 .../lustre/include/linux/libcfs/libcfs_crypto.h    |   11 +-
 drivers/staging/lustre/include/linux/lnet/api.h    |    1
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    6 -
 .../staging/lustre/lnet/klnds/socklnd/socklnd.h    |   11 --
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |   10 --
 .../lustre/lnet/klnds/socklnd/socklnd_lib.c        |    2
 drivers/staging/lustre/lnet/libcfs/Makefile        |    4 -
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   |    2
 .../lustre/lnet/libcfs/linux/linux-crypto.c        |   29 ++---
 .../lustre/lnet/libcfs/linux/linux-curproc.c       |  108 ----------------=
---
 .../staging/lustre/lnet/libcfs/linux/linux-mem.c   |   51 ---------
 .../staging/lustre/lnet/libcfs/linux/linux-prim.c  |  113 ----------------=
----
 drivers/staging/lustre/lnet/lnet/acceptor.c        |    2
 drivers/staging/lustre/lnet/lnet/api-ni.c          |   15 +--
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |   10 +-
 drivers/staging/lustre/lnet/lnet/router.c          |    2
 drivers/staging/lustre/lnet/selftest/timer.c       |    2
 drivers/staging/lustre/lustre/fid/fid_request.c    |  106 ++++++----------=
---
 drivers/staging/lustre/lustre/fid/lproc_fid.c      |   44 +++++---
 drivers/staging/lustre/lustre/include/lu_object.h  |    7 -
 drivers/staging/lustre/lustre/include/lustre_fid.h |    2
 drivers/staging/lustre/lustre/include/lustre_lib.h |   18 ++-
 drivers/staging/lustre/lustre/include/lustre_sec.h |    3 -
 drivers/staging/lustre/lustre/include/obd_class.h  |    8 +
 .../staging/lustre/lustre/include/obd_support.h    |    2
 drivers/staging/lustre/lustre/llite/dcache.c       |    2
 drivers/staging/lustre/lustre/llite/dir.c          |   10 +-
 drivers/staging/lustre/lustre/llite/file.c         |   12 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |    8 +
 drivers/staging/lustre/lustre/llite/llite_mmap.c   |    8 +
 drivers/staging/lustre/lustre/llite/xattr.c        |    2
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |    4 -
 drivers/staging/lustre/lustre/lov/lov_ea.c         |    2
 drivers/staging/lustre/lustre/lov/lov_io.c         |    2
 drivers/staging/lustre/lustre/lov/lov_lock.c       |    2
 drivers/staging/lustre/lustre/lov/lov_object.c     |    4 -
 drivers/staging/lustre/lustre/lov/lov_pack.c       |    2
 drivers/staging/lustre/lustre/lov/lov_request.c    |    2
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      |    2
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |    6 +
 drivers/staging/lustre/lustre/obdclass/linkea.c    |   16 ++-
 .../lustre/lustre/obdclass/linux/linux-module.c    |    4 -
 drivers/staging/lustre/lustre/obdclass/llog.c      |   22 ++--
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   70 ------------
 .../lustre/lustre/obdclass/lustre_handles.c        |    4 -
 .../staging/lustre/lustre/obdecho/echo_client.c    |    8 +
 drivers/staging/lustre/lustre/osc/osc_cache.c      |    4 -
 drivers/staging/lustre/lustre/osc/osc_page.c       |    2
 drivers/staging/lustre/lustre/osc/osc_request.c    |    2
 drivers/staging/lustre/lustre/ptlrpc/client.c      |   93 +++++-----------
 drivers/staging/lustre/lustre/ptlrpc/import.c      |   34 ++----
 drivers/staging/lustre/lustre/ptlrpc/layout.c      |    2
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |    8 -
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |   15 +--
 drivers/staging/lustre/lustre/ptlrpc/recover.c     |   28 ++---
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |    4 -
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |    4 -
 drivers/staging/lustre/lustre/ptlrpc/sec_null.c    |    8 +
 drivers/staging/lustre/lustre/ptlrpc/sec_plain.c   |    8 +
 drivers/staging/lustre/lustre/ptlrpc/service.c     |   27 ++---
 62 files changed, 295 insertions(+), 769 deletions(-)
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.=
c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c

--
Signature

_______________________________________________
lustre-devel mailing list
lustre-devel@lists.lustre.org
http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
