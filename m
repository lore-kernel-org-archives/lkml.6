Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75B92087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeL2SZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:25:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbeL2SZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:25:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBTIPcX4141713
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:25:39 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pp5xyccwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:25:37 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 29 Dec 2018 18:24:58 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Dec 2018 18:24:55 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBTIOs9220971530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Dec 2018 18:24:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FC5B2064;
        Sat, 29 Dec 2018 18:24:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2F47B205F;
        Sat, 29 Dec 2018 18:24:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 29 Dec 2018 18:24:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 73AB616C5EA1; Sat, 29 Dec 2018 10:25:08 -0800 (PST)
Date:   Sat, 29 Dec 2018 10:25:08 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers: move the nolibc header from rcutorture to
 tools/include/nolibc/
Reply-To: paulmck@linux.ibm.com
References: <20181229180453.15889-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229180453.15889-1-w@1wt.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18122918-2213-0000-0000-000003335DAD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010311; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01138878; UDB=6.00592505; IPR=6.00919068;
 MB=3.00024895; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-29 18:24:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122918-2214-0000-0000-00005CC5830D
Message-Id: <20181229182508.GJ4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812290169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 07:04:53PM +0100, Willy Tarreau wrote:
> As suggested by Ingo, this header file might benefit other tools than
> just rcutorture. For now it's quite limited, but is easy to extend, so
> exposing it into tools/include/nolibc/ will make it much easier to
> adopt by other tools.
> 
> The mkinitrd.sh script in rcutorture was updated to use this new location.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Thank you, Willy!  I have queued all four of these.  Should there
be a MAINTAINERS file entry for the new include/nolibc home for this
library code?

							Thanx, Paul

> ---
>  tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h | 0
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh                  | 4 ++--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h (100%)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/include/nolibc/nolibc.h
> similarity index 100%
> rename from tools/testing/selftests/rcutorture/bin/nolibc.h
> rename to tools/include/nolibc/nolibc.h
> diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> index da29839..d93bca1 100755
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -124,8 +124,8 @@ if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
>     | grep -q '^yes'; then
>  	# architecture supported by nolibc
>          ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
> -		-nostdlib -include ../bin/nolibc.h -lgcc -s -static -Os \
> -		-o init init.c
> +		-nostdlib -include ../../../../include/nolibc/nolibc.h \
> +		-lgcc -s -static -Os -o init init.c
>  else
>  	${CROSS_COMPILE}gcc -s -static -Os -o init init.c
>  fi
> -- 
> 2.9.0
> 

