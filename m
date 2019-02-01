Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B8C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5014C2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rWsV8aN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfBAVVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:21:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50958 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:21:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11LJ4Te082234;
        Fri, 1 Feb 2019 21:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dhpkZZdzz+1m3AsfE8doVtl5zOEd1OtdZUCjhlrOFkE=;
 b=rWsV8aN3Om0VKWfSG8URjpvtjiUo4EL2c1BNbYA+mpZbKO3H3LKhJ1kYODoxdtGfjGtL
 3XSbEY0ddFTJPQHuL7o6aYOQU4jt1VYxwkAy9bKnDe9rSnDnALfJRfWV33ItVw33L2CZ
 kWrqBTeeCRemEqqOFXvWkhqugVOr00tk9MPbdh6sEEDu/H4R833HF+aWXp5KsRUuk5eI
 6F44cSPItps4wwhtfLOHRH6xEMGw5iHs69Yj1lHE7paMZLRGF/jULSxBbozopXY7Mvix
 /+0s2KmTVfT6cNP1w/JOpe66/wcdh+9WJf47YkKiv+mmxJLZ3PkGoaWUp19Rdin9XiPS dA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2es4fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 21:20:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x11LKulr032732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 21:20:57 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x11LKujP026297;
        Fri, 1 Feb 2019 21:20:56 GMT
Received: from [10.39.246.40] (/10.39.246.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 13:20:55 -0800
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
Date:   Fri, 1 Feb 2019 16:20:53 -0500
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D5F7272-5E25-49C8-BAD4-D0D402068BA0@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131095638.GA31534@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3259)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 31, 2019, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 30, 2019 at 10:01:32PM -0500, Alex Kogan wrote:
>> Lock throughput can be increased by handing a lock to a waiter on the
>> same NUMA socket as the lock holder, provided care is taken to avoid
>> starvation of waiters on other NUMA sockets. This patch introduces =
CNA
>> (compact NUMA-aware lock) as the slow path for qspinlock.
>=20
> Since you use NUMA, use the term node, not socket. The two are not
> strictly related.
Got it, thanks.

>=20
>> CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads =
are
>> organized in two queues, a main queue for threads running on the same
>> socket as the current lock holder, and a secondary queue for threads
>> running on other sockets. Threads record the ID of the socket on =
which
>> they are running in their queue nodes. At the unlock time, the lock
>> holder scans the main queue looking for a thread running on the same
>> socket. If found (call it thread T), all threads in the main queue
>> between the current lock holder and T are moved to the end of the
>> secondary queue, and the lock is passed to T. If such T is not found, =
the
>> lock is passed to the first node in the secondary queue. Finally, if =
the
>> secondary queue is empty, the lock is passed to the next thread in =
the
>> main queue.
>>=20
>> Full details are available at =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3D7sFZrsdpLJxLRHIFWN_sE6zgKy20Ti8=
lOoepiEyipAo&s=3D5VRAQVjw0B1SCjvBLzzwxkHQ6TZ3FIl_tGDfvn3FXvo&e=3D.
>=20
> Full details really should also be in the Changelog. You can skip much
> of the academic bla-bla, but the Changelog should be self contained.
>=20
>> We have done some performance evaluation with the locktorture module
>> as well as with several benchmarks from the will-it-scale repo.
>> The following locktorture results are from an Oracle X5-4 server
>> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
>> cores each). Each number represents an average (over 5 runs) of the
>> total number of ops (x10^7) reported at the end of each run. The =
stock
>> kernel is v4.20.0-rc4+ compiled in the default configuration.
>>=20
>> #thr  stock  patched speedup (patched/stock)
>>  1   2.710   2.715  1.002
>>  2   3.108   3.001  0.966
>>  4   4.194   3.919  0.934
>=20
> So low contention is actually worse. Funnily low contention is the
> majority of our locks and is _really_ important.
This can be most certainly engineered out, e.g., by caching the node ID =
on which a task is running.
We will look into that.

>=20
>>  8   5.309   6.894  1.299
>> 16   6.722   9.094  1.353
>> 32   7.314   9.885  1.352
>> 36   7.562   9.855  1.303
>> 72   6.696  10.358  1.547
>> 108   6.364  10.181  1.600
>> 142   6.179  10.178  1.647
>>=20
>> When the kernel is compiled with lockstat enabled, CNA=20
>=20
> I'll ignore that, lockstat/lockdep enabled runs are not what one would
> call performance relevant.
Please, note that only one set of results has lockstat enabled.
The rest of the results (will-it-scale included) do not have it.

Regards,
=E2=80=94 Alex

