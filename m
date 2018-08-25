Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A49C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 10:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D0D217AA
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 10:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D0D217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeHYOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 10:21:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:47611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeHYOVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 10:21:13 -0400
Received: from localhost.localdomain ([196.52.84.56]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MQQzk-1gNGGA0XrI-00TpOC for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018
 12:42:38 +0200
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Disabling CPU vulnerabilities workarounds
To:     linux-kernel@vger.kernel.org
Message-ID: <575b6581-7dcb-96a9-b06e-9f74dda5fa86@gmx.com>
Date:   Sat, 25 Aug 2018 10:42:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qAmQzM32xtJF+++IUmu4FgOafu1Tz1qWwaSDj6uasNWn4cyQJyp
 0Wm5DZBw1DoQgIXpTKNZEWg2Eo58pg8tQSxrfCKvU/L3+uZt/wPouqfuyEbxbLSn3z5+DWw
 RFbQzynfqfdyydXM376DLzL7e85liNf91La1/TLt6VACCqSfbGjPfFbP5WRAiq7riNadRA4
 md/IQafjTx42OZ6FdefHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:orJFjgXiLak=:/z3QAqFqy7h8hs2JbjKVNB
 Q5xxg+KI+D7H+xIrpBZKbo+KrVUEKyfY1XRj+pKab9lSejU08Q9kgwfCss90ZOPnsG+cZSJOT
 WQzk4sO+1/dWvUCVUyoqMeLwwju/zwfWbyIkhPnBo/aVEuso4JZIp5uB1Aq2Fx/z49IttUvQJ
 xAruEPHk10eY63zoi6rV0U3BHd2G8JDbjEeXvjXNyLW2fvXFSb6xQuYWoDkH1wCLxuTFc0yOp
 W1+F+nPVMIRRus6Kk5kbA5BxiZTn2Gf1tbt+AQ5cxHZjMwRaVT+LGrfc48DkiglWkU5E71r6K
 bhyL1UrUKPVKPVe8hn08HbdxKNzl/aLk9OvSY00lWggZ9/OxrExoHyaEN+5rbbtsnbDWWtYB8
 6bJyYH5SiJfbmPCqtKifiDH+JXWVMkQOtd6lw06UeDZRZtmdfJcEbAihG8dM2KAMxzfB/xHrv
 28FvR+ZsudXJk1mDDG04LPRXEG53SOTmFxGtfYJdxk49ycxN3HQANeu6jiSroCLWKE+1ghg4d
 lRlGCYheHTuccwsPkuntoFablBIyO2aUSRjoFG/dQNkqdSbj5p8yTnIFgX4RXMtwMKrYCokOS
 W2JOCZuUM8L8/wCiVF1la64rNhoFqYlv7e/AVOZc7d3YAfmJL5hSKn3PoxsVcLTC+aVsC+EjU
 MmCvW6W7zP2Mhg1E3TT9dNnurVgc5RgBMyfjbtTnMs0Iq4idPlakusjfk4s53dygq1YwqInY4
 fPz7sUFrbJk3sUB7KIZ1rfSqifb4YOsdh2+iF9diMtDTQozpEiTlIrR6sShpCw3sHPmacT3sk
 DfaKyG4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

As time goes by more and more fixes of Intel/AMD/ARM CPUs 
vulnerabilities are added to the Linux kernel without a simple way to 
disable them all in one fell swoop.

Disabling is a good option for strictly confined environments where no 
3d party untrusted code is ever to be run, e.g. a rendering farm, a 
supercomputer, or even a home server which runs Samba/SSH server and 
nothing else.

I wonder if someone could wrote a patch which implemented the following 
two options for the kernel:

* A boot option option which allows to disable most runtime 
protections/workarounds/fixes (as far as I understand some of them can't 
be reverted since they are compiled in or use certain GCC flags), e.g. 
let's call it "insecure" or "insecurecpumode".

* A compile-time CONFIG_ option which disables all these fixes 
_permanently_ without a way to turn them later back on during runtime.

Right now linux/Documentation/admin-guide/kernel-parameters.txt is a 
mess of various things which take ages to sift through and there's zero 
understanding whether you've found everything and correctly disabled it.


Best regards,
Artem
