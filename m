Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D3620830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IeLh68hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D3620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbeKGEcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:32:50 -0500
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:13592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730358AbeKGEct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/IcJSUnPRE66kmE17PNxEneXUtveuPCBOyFyDiM7xc=;
 b=IeLh68hRzbjrjGg4cWBisyC8XUA4OdaAxmeawLbnfVg3kngE3i98LYuydER2vk1mKLby+HlihQM1hAIwgzYHNTSO9CGkDjosKplhfPzdhrjUE/oYDqE/intRsDTeM0/a3h0bj5PrVQ4grMjW9YvctEzaqji1EP05PmlW2WjK7f8=
Received: from VI1PR08MB2942.eurprd08.prod.outlook.com (10.170.239.161) by
 VI1PR08MB0365.eurprd08.prod.outlook.com (10.162.12.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Tue, 6 Nov 2018 18:46:51 +0000
Received: from VI1PR08MB2942.eurprd08.prod.outlook.com
 ([fe80::a9cc:5e09:8877:7d92]) by VI1PR08MB2942.eurprd08.prod.outlook.com
 ([fe80::a9cc:5e09:8877:7d92%4]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 18:46:52 +0000
From:   Denis Lunev <den@virtuozzo.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>,
        Vitaly Mayatskikh <v.mayatskih@gmail.com>
CC:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Wolf <kwolf@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Thread-Topic: [PATCH 0/1] vhost: add vhost_blk driver
Thread-Index: AQHUdecZlrnmWITEf0m8SDJC6Fn2DKVDFpIA
Date:   Tue, 6 Nov 2018 18:46:51 +0000
Message-ID: <964bc8d7-8a5c-774b-4153-b1a8a044b144@virtuozzo.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <20181102142446-mutt-send-email-mst@kernel.org>
 <20181106154048.GB31579@stefanha-x1.localdomain>
In-Reply-To: <20181106154048.GB31579@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0201CA0024.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::34) To VI1PR08MB2942.eurprd08.prod.outlook.com
 (2603:10a6:802:1f::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [93.175.28.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0365;20:zREmFOpi0bFj/pwLVF1NJY/bjQhnghw9tz2WmyFtNlBxopfnB0cXdVRQDSVq8qbCrhlzheyF8bZtBnn6dhdpwREwV6W3m5cMc0LtIkIQf+LMb9lTKgBAiXk9x15oN63OFstB+0tc7pylklo1uh2jf8+HHOosdVSSweHNpiBaonw=
x-ms-office365-filtering-correlation-id: e9aa4eb6-79ba-44d5-628c-08d644183720
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0365;
x-ms-traffictypediagnostic: VI1PR08MB0365:
x-microsoft-antispam-prvs: <VI1PR08MB036572C44EF7C860105354F9B6CB0@VI1PR08MB0365.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0365;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0365;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(366004)(376002)(346002)(199004)(189003)(6512007)(6246003)(2616005)(4326008)(25786009)(486006)(446003)(71200400001)(53936002)(11346002)(71190400001)(97736004)(229853002)(81166006)(6436002)(476003)(39060400002)(86362001)(54906003)(6116002)(68736007)(5660300001)(478600001)(3846002)(81156014)(8936002)(316002)(110136005)(14454004)(8676002)(256004)(36756003)(105586002)(31696002)(305945005)(7736002)(102836004)(386003)(6506007)(26005)(2906002)(52116002)(186003)(53546011)(106356001)(66066001)(76176011)(31686004)(2900100001)(6486002)(99286004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB0365;H:VI1PR08MB2942.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kBmhuyI+iMXsnWuUYhrOhfUvEdywYfvPYHFm0lOprhbo+ud7Z+Qi2CIaJL0XVlDkfF88WqvqyEe8u1pcGYdC5o5EMb3g/jhWbPTGTjTcrPwYJHQCYjYkqiQHjfJJnCQD1e7ghZ2d90K2FKXG6m7hQFpkgKhnfSmIAkOZNJuYCmlHy6Ls3o9y67hovskcXGOsLRx72Ug8nVOQmZj2RLOgaVUigVJRscw3FS6iYI3w0U8TCXidVdvy0O6Xq+tYDOCM75EyU7RAO2eYp0H9WqZIstD1GO40AV6YFGW1st0bNEjn+cP7l6RbInutsfNI8brcAZ70BEPSXCoTo4A1b2SHBrgFLnQuj5ceWWGGYBQ60fE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F608BE4AB4D2EF4196F9267C921784A0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aa4eb6-79ba-44d5-628c-08d644183720
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 18:46:51.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 6:40 PM, Stefan Hajnoczi wrote:
> On Fri, Nov 02, 2018 at 02:26:00PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
>>> vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
>>> driver allows VM to reach a near bare-metal disk performance. See IOPS
>>> numbers below (fio --rw=3Drandread --bs=3D4k).
>>>
>>> This implementation uses kiocb interface. It is slightly slower than
>>> going directly through bio, but is simpler and also works with disk
>>> images placed on a file system.
>>>
>>> # fio num-jobs
>>> # A: bare metal over block
>>> # B: bare metal over file
>>> # C: virtio-blk over block
>>> # D: virtio-blk over file
>>> # E: vhost-blk bio over block
>>> # F: vhost-blk kiocb over block
>>> # G: vhost-blk kiocb over file
>>> #
>>> #  A     B     C    D    E     F     G
>>>
>>> 1  171k  151k  148k 151k 195k  187k  175k
>>> 2  328k  302k  249k 241k 349k  334k  296k
>>> 3  479k  437k  179k 174k 501k  464k  404k
>>> 4  622k  568k  143k 183k 620k  580k  492k
>>> 5  755k  697k  136k 128k 737k  693k  579k
>>> 6  887k  808k  131k 120k 830k  782k  640k
>>> 7  1004k 926k  126k 131k 926k  863k  693k
>>> 8  1099k 1015k 117k 115k 1001k 931k  712k
>>> 9  1194k 1119k 115k 111k 1055k 991k  711k
>>> 10 1278k 1207k 109k 114k 1130k 1046k 695k
>>> 11 1345k 1280k 110k 108k 1119k 1091k 663k
>>> 12 1411k 1356k 104k 106k 1201k 1142k 629k
>>> 13 1466k 1423k 106k 106k 1260k 1170k 607k
>>> 14 1517k 1486k 103k 106k 1296k 1179k 589k
>>> 15 1552k 1543k 102k 102k 1322k 1191k 571k
>>> 16 1480k 1506k 101k 102k 1346k 1202k 566k
>>>
>>> Vitaly Mayatskikh (1):
>>>   Add vhost_blk driver
>>
>> Thanks!
>> Before merging this, I'd like to get some acks from userspace that it's
>> actually going to be used - e.g. QEMU block maintainers.
> I have CCed Kevin, who is the overall QEMU block layer maintainer.
>
> Also CCing Denis since I think someone was working on a QEMU userspace
> multiqueue virtio-blk device for maximum performance.
>
> Previously vhost_blk.ko implementations were basically the same thing as
> the QEMU x-data-plane=3Don (dedicated thread using Linux AIO), except the=
y
> were using a kernel thread and maybe submitted bios.
>
> The performance differences weren't convincing enough that it seemed
> worthwhile maintaining another code path which loses live migration, I/O
> throttling, image file formats, etc (all the things that QEMU's block
> layer supports).
>
> Two changes since then:
>
> 1. x-data-plane=3Don has been replaced with a full trip down QEMU's block
> layer (-object iothread,id=3Diothread0 -device
> virtio-blk-pci,iothread=3Diothread0,...).  It's slower and not truly
> multiqueue (yet!).
>
> So from this perspective vhost_blk.ko might be more attractive again, at
> least until further QEMU block layer work eliminates the multiqueue and
> performance overheads.
>
> 2. SPDK has become available for users who want the best I/O performance
> and are willing to sacrifice CPU cores for polling.
>
> If you want better performance and don't care about QEMU block layer
> features, could you use SPDK?  People who are the target market for
> vhost_blk.ko would probably be willing to use SPDK and it already
> exists...
>
> From the QEMU userspace perspective, I think the best way to integrate
> vhost_blk.ko is to transparently switch to it when possible.  If the
> user enables QEMU block layer features that are incompatible with
> vhost_blk.ko, then it should fall back to the QEMU block layer
> transparently.
>
> I'm not keen on yet another code path with it's own set of limitations
> and having to educate users about how to make the choice.  But if it can
> be integrated transparently as an "accelerator", then it could be
> valuable.
>
> Stefan
Stefan,thank you very much for adding me into the loop :)
Patches themselves are very interesting and worth to
discuss.

First of all, I am not a very big fan of SPDK approach
and like kernel kernel implementation much more.
The reason for this is very simple. We are are not
discussing the overhead of the emulation. It would be
very interesting to compare CPU usage of each approach
and compare the overhead.

The problem is that we can not afford too costly
emulation for most scenarios.

I do think that kernel based approaches generates not
only more IOPSes but less overhead too.

Den
