Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B299C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1FA24BFD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrEqHSEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1FA24BFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeFWNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 09:12:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFWNMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 09:12:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ND9M8M193046;
        Sat, 23 Jun 2018 13:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=RN9iRWNrlST7nEsJWa4e9MxRmiuL1xnmK6tptNEsCvE=;
 b=HrEqHSEaNlAkq2crdmi8DZXn0w0T2VYbfgTz0ovehjwdlZctm47F7bEwF9tNtuaPOagu
 1HzQ2r0k1OOE1oLsbeXnYv1WqQtj62aZLFf5tgXz/YAgtCpQvUUSR4Kx+1auRXafAdxu
 elVFmkR4cYsMvo7wWNsTA4cDOS1JQeZ7FJQUIz96ZiJALaI+/DBG2pnuWeJXeF/oVuix
 BZE6/ucWgmwlTSclQG/v6XxGOYVHpPiAB4j0HaxulrMU5xRam8coA3OqXvCNtDiPqN4S
 8ROKtNqz5nQ2XLjmE88iP1lDfFr+ybEbzhis+Cz3Z5CopEtW1UAF8/Uw3st1mQc1OysO qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jsfg0rfu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 13:12:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5NDCDZW003009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jun 2018 13:12:14 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5NDCDlC012797;
        Sat, 23 Jun 2018 13:12:13 GMT
Received: from mail-ot0-f170.google.com (/74.125.82.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Jun 2018 06:12:13 -0700
Received: by mail-ot0-f170.google.com with SMTP id d19-v6so10452710oti.8;
        Sat, 23 Jun 2018 06:12:13 -0700 (PDT)
X-Gm-Message-State: APt69E2qEeXkWbKija+guJGX10nV0+ROqHF/cRzACXJ8agjoAb2fiuBG
        t75S25GIexvSSbL8c4lrE7V8gH3/pNemoC+bkBo=
X-Google-Smtp-Source: ADUXVKIdyPfYZ0cSCs6YyyEuAnFqxLJjxY7g4n0k5oF10TZJuaBG/0VocPYC+BreNa4Cx4tTR1PjFECp8XEPhyFAeTk=
X-Received: by 2002:a9d:4609:: with SMTP id y9-v6mr3023161ote.259.1529759533015;
 Sat, 23 Jun 2018 06:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-3-pasha.tatashin@oracle.com> <20180623091648.GA29468@zn.tnic>
In-Reply-To: <20180623091648.GA29468@zn.tnic>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Sat, 23 Jun 2018 09:11:36 -0400
X-Gmail-Original-Message-ID: <CAGM2reYWb4bHzydh4PQj9vZfjaX+BQ_hTJiB3krJ-3AhC2MvuA@mail.gmail.com>
Message-ID: <CAGM2reYWb4bHzydh4PQj9vZfjaX+BQ_hTJiB3krJ-3AhC2MvuA@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] x86: initialize static branching early
To:     bp@alien8.de
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, Petr Mladek <pmladek@suse.com>,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8932 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806230158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thank you.

>
> Also, please take the patch below into your queue and keep it a separate
> patch in case we have to revert it later. It should help in keeping the
> mess manageable and not let it go completely out of control before we've
> done the cleanup.

OK. I will include it into the next itiration. Once I get some more
feedback from Thomas and Peter.

Pavel
