Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEEITt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:19:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:59531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeEEITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:19:47 -0400
Message-ID: <1525508378.5406.6.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Date: Sat, 05 May 2018 10:19:38 +0200
In-Reply-To: <1525463210.622.1.camel@gmx.de>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7SCqs7RtfH8TsyH6K883l0BX+TyFNujGUz2ss3e7EtPLIw9e6V9
 Ee4CzWZtAtjlzn1nyVeadpwvnwq62Ud2bJ/G4PNLEH67G/XURI5DX1KYDf+ogK4ArB9xh60
 Ixe5G1BZveZSl3m903i5q04kZpl/4vwam4CtLCyksmHFys9nyyV3sh0QVxWvM6ydgl+UVyP
 nDWts4H4T1vLygmc42Msw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SN92bNAak1g=:twl5Yhh+UMn3sNe11183Wk
 4T6eJYq7gGpvrG5li20kWvFNBRVzOEBSvPdtLJnF/s+8f98u5LuQe/yTxR/BfQYM45zKEBeIX
 IOpIqPv3eki01DsX5aFcosmVsFoBCwmc2T0oNlv5fAjYPrvfES94f0NCYXxBVmoaH6+KcErAE
 DMZVMou7YhKBCX27qguMrl2vHFksaQXLMmbjRyX/LzaUR9c77v6qbVxj9v67v43BPrpx/l0zo
 wY7jMyod4v4WQOyva9um0wTHkktwRlSNdDSi/dP7CyLwb+pML887PL+kXj8WBB9HdkMZqAG3v
 HmK4qdQlRTYZkLnuox6kRXuZizGbzF9jEd4NHGL+fem5sb8Y9ID7s5CqBFwglb0yVPpzW5h4O
 gjD2Llkk5SSXWpMf7CR8d+DjRsoJFLwcE1BI9K7/XfJumU4ffn12R9higd7s9jh6q5WdLA/5Q
 mQIJ15nd9r9s+4Dip5Fzai2bsZfNZChpgfcjaohaC1skD0qxNgpabyItOkTwrVUWLKN1U7B0+
 /x/yWYfooG0mIFEqKv+g25YJYg9qHlR6YC+uBnLy08PxxVooLliHh3PMYuRSBuzqBkgPkh62h
 OfBz5EKpY/JezlDxhm9jRummEcy0D66oqnxQPFKRb/n6JTmhDMxbKCVft/YETYU/8apm92LCH
 yVaY60PzPuq65wlPot6JBqPBlRRVnA1DJZ/Vet6I/bwwOfQC1gMkSPCF0bH72u94qM67lc4zW
 /rohAfZE+a/JS5AAFayUIO7PgIFr7HHNQWR9Hr2kel5dH3w8O3k/19Hmg46HwL4R4DLpOpsy4
 HAs8EPc
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-04 at 21:46 +0200, Mike Galbraith wrote:
> Tentatively, I suspect you've just fixed the nasty stalls I reported a
> while back.

Oh well, so much for optimism.  It took a lot, but just hung.
