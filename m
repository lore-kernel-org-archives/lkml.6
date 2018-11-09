Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13843C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5FA20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5FA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeKJHS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:18:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:42193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJHS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:18:57 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LtlG5-1fK0xI2msX-0117CY; Fri, 09
 Nov 2018 22:36:09 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: ODEBUG: Out of memory. ODEBUG disabled
Message-Id: <54B1AA39-2C58-4B0C-B8A8-9F85EBA7C963@gmx.us>
Date:   Fri, 9 Nov 2018 16:36:04 -0500
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhong Jiang <zhongjiang@huawei.com>
To:     open list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:jgb5dMG2Zi/qpRtDeVGrRhBxC/4EFwtkBh0h2+lp5PI5eLZhUbG
 /P7OnAzB14VWButhskPkuy5wzSM3s/8MfHJkAZXGppSYf19GJS5kQfpjtMMqC3VT82iEQb2
 QrlbsFVHn96FVQ1uHtaTjPmfCc1Tya7xTimQIr1GYlixIr88qfsuHSBGywRszI3QPQJEGz7
 zdI2oQ4SSjF9XgmrwxQcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+L6Ng4mqCLo=:kv+Tk7PO33GoGDbSn8yoOW
 aeg0p2R7/n5kwcBQFXB1SpK9jrppoOce6ZcOx8uz+jsdujh2DhiyLTjyHUtqW1e621nVZvsDq
 nCtIpc/NcZG38aWtQCMP6t1iar0lixCEY4N+tfUHqpTwzXTo5I3Pih6M0hcbI7HDsNunZ0Zjp
 mAX+LXkH+eYrM8vEkniZzHcL3if3/+GppbE5nKRDRmo0Cn+SMmB8BqSHsYt+Btp5866CNyQ10
 r7pOIaodZQIJm4uWOTjlC2xZ5Rh8B/9qHHMhojImhFXFUDvFsZofwz+0HdhOpSYv3HYpyNg+F
 XvkG5h+9R7WVDDrJdVVdbUcDl2UYllb/Z2GZSKNpUeH6vG8EFXr2spal3QswQiYaULTwMAwik
 PQmELabtmkm3HnePT15uIn2BW4YWP4pj268UTlV1iqvJSDkdK9zuswoRPDyy834NJl2k6JZjj
 9ew+6mW+ds4k3NgWH4eo7UOLsTupy0R4EkVMqIbPnliIkl8W9RAsMW8i/uZSURUB+xSb0bL48
 2gvLC16w/Mwyp53YzFTS3p36D2lMOdNCCvxAsESbc/jBsIdFdAOwBO/WDQ+RJ4Ih2SlbKMjrA
 lB/SCNFQM5rOqju8IYb93aSm2z8VdclWpAvNoVGgCZpHmtH0J8SAmKNACiOEl9CENmkt2C6Yh
 +i+Fak1Zv/NJw+uM82cEq/R4F59E2l3J/3FYc/4Th3D5saohldeHcBvQSJWhD0UbQNB5iUoP0
 PYTv1kSws6JfFCR/+no9kt5eygNSiyHBHjKFzPKrTcNJc3/CYBVYarUJ69cFtOa+3fgun1WVD
 kHTBon6+8OJYIDcdPrfjn1tDTL0aphMH42M1+UxoCaPpye9pB2bM+OhQhpv82Oj7mCktCduUe
 KGAWmKQa+PJeRcAGmDosy3Vl0rrAeMzbwujlEGi+esv2doCc+OP3FENX14wCxp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a bit annoying on this aarch64 server with 64 CPUs that is
booting the latest mainline (3541833fd1f2) causes object debugging
always running out of memory.

I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
to make it work. Is it expected that object debugging is not going
to work with large machines?
