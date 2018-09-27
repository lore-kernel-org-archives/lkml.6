Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD09C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6218216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T8QOZZJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6218216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeI0UXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:23:20 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:43431 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI0UXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:23:20 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 16:23:19 EDT
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20180927135843usoutp02d45cc7889f5a0a0c25c4b264a55f0f2c~YRnDmvVGw0927309273usoutp023;
        Thu, 27 Sep 2018 13:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20180927135843usoutp02d45cc7889f5a0a0c25c4b264a55f0f2c~YRnDmvVGw0927309273usoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538056723;
        bh=ROiSMdpv9kD7V19fPhy+LBceqWdDfxFDJkoiVwGN3HY=;
        h=Reply-to:Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=T8QOZZJOEKGcoFdeKU8j+fvodTe4PGHzo5g6Rxnj0mWdx7v6ZDaUm4qF9d4jXBdr0
         ZMOOoqiFBW8stVhiyA3iIM4CjmBk2ptEY0QmK0El1GT6CQnIpFyn63OsI/OZ7dyN0z
         607khrka6I2T6gHEteQAEXtIySucm9j5YBvTBU2o=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180927135843uscas1p191bd62293b069b89cdc6defb6c3742da~YRnDbGRSE1110411104uscas1p1h;
        Thu, 27 Sep 2018 13:58:43 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 57.4E.04477.312ECAB5; Thu,
        27 Sep 2018 09:58:43 -0400 (EDT)
Received: from ussmgms1.samsung.com (unknown [182.198.245.179]) by
        uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180927135842uscas1p2bcff0065e45b80ad107288e9b1ecf241~YRnDDX8i22549625496uscas1p2i;
        Thu, 27 Sep 2018 13:58:42 +0000 (GMT)
X-AuditID: cbfec36d-1c1ff7000000117d-32-5bace21343d3
Received: from ussync2.samsung.com ( [203.254.195.82]) by
        ussmgms1.samsung.com (USCPMMTA) with SMTP id FD.2E.04155.212ECAB5; Thu, 27
        Sep 2018 09:58:42 -0400 (EDT)
Received: from srafidmail02pr.sisa.samsung.com ([105.144.21.51]) by
        ussync2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTP id <0PFP00KBZW5US740@ussync2.samsung.com>;
        Thu, 27 Sep 2018 09:58:42 -0400 (EDT)
Received: from sisasmtp.sisa.samsung.com (sraex01sc.sisa.samsung.com
        [105.160.16.22]) by srafidmail02pr.sisa.samsung.com (Postfix) with ESMTP id
        2F2AD3C07F7;    Thu, 27 Sep 2018 13:58:42 +0000 (UTC)
Received: from [105.160.10.155] (105.160.10.155) by
        sraex01sc.sisa.samsung.com (105.160.16.22) with Microsoft SMTP Server (TLS)
        id 15.0.1367.3; Thu, 27 Sep 2018 06:58:40 -0700
Reply-to: shuah.kh@samsung.com
Subject: Re: [PATCH] rseq/selftests: fix parametrized test with -fpie
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        stable <stable@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah.kh@samsung.com>
Message-id: <a7bae2ff-1f4d-dbfc-43f8-e7a89f319abb@samsung.com>
Date:   Thu, 27 Sep 2018 07:58:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-version: 1.0
In-reply-to: <20180927092235.77282e35@vmware.local.home>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Originating-IP: [105.160.10.155]
X-ClientProxiedBy: sracas01sc.sisa.samsung.com (105.144.22.46) To
        sraex01sc.sisa.samsung.com (105.160.16.22)
X-Content-Scanned: Fidelis Mail
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGPfcbtuq1YHjDcJouxtjNr8gfJ5GRZXPJXbKYzagjNlEbuUMj
        LaYXEEyMzJbBFJ2bFFj9oBggWIpILypIQkhBSsBB1KqRotZGiEJBG6oMGHOWWxP++533eZ+c
        5zk5HKnuYRK5A8Zs0WTUZ2qYWOp695uBtXEBp26Dz0Xj841OBnc9mGLx70O1BHY2/0LgV7Ul
        CD98G0S4baydwmVNCXjaq8Hv7FlYnipm8L2b5xlcPvSKwb57KlzfUEBj+e/bJL7bYSdw7xk/
        i8flKRp7TnUQuPVyHY3bi/0ELn15hcXW8GsK25sCCMsuK4kDp8dZ/DLUQ32VJDwNzlGC86IT
        CRZzCSPU9AUZ4Q/zBCtUtoaQ0Gp7zAqW9kFWsLtyBLlOKwyOfSm4HL8xwkR/Pyv0VMxSwnNv
        OSH43TL1Q/yu2JR0MfNArmhan7o3dv/o9T2HrDF5/zZcYgpQFXsCxXDAJ4PjViV1AsVyav4y
        gm5PNaMcJhGERiapD1sjrXZCEWoRnGq7SEYENV9EwLVfv1cED4Ix32zULiM4Wf4suvUpHK+u
        n+c4/ltoKbcwEY7nd4PF0YIiBpKfZsF/o2z+PoZfDZNjLe8TcpyKT4WattTImOJXQUN4iI7w
        Mj4NuvxVKMIqfin8c/bJvDWGx+D3tBMRJvk18CL8J6VwApgLH0V5BcjOcVKppoHQYx+tsBEK
        b9ujlVfAi/ob85WBD3Iw3HQr+mJbwOWqiJrjYNTTHJ0nwYytm1QMRQguVP8VFUoRvK6JV3gz
        vOsYYJUUi2FuJoDOoM9sC0rYFgS3LQhuWxDcjigHSsiRJEOGKG00iofXSXqDlGPMWLcvy+BC
        7/9333+dhhbU1bfPjXgOaT5WXW2q16lpfa6Ub3Aj4EhNvIp94tSpVen6/COiKWuPKSdTlNzo
        E47SJKh6207q1HyGPls8KIqHRNMHleBiEgtQnZjibdxRVpLSSWu59E2jrgeNvdv6Ld7Eqq0T
        U5+bM8M/7ty9/ItvzsqF06cr8ndalxTd2a5qdoTSjsVtHr7z6Outlvs/L/Lp8lcGuTx/+Kei
        wFOr16KtSlt6/1znskp6eXLtd70fpSw5vKV4YHGNmbjgzqWOJpVesR3Uao/v8K6d1VDSfv1G
        LWmS9P8DO3flSdsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe885O+dsOTwuzRe7KIOwe1p9eD+UBFG8faisQUlCOvKgopu1
        k90IstRSKcu85ZJakbe2pdsxcxpLpqVmVxUrUxOp0NSWqZl0MeeK/PZ7nvf/PH9e+LOkolni
        x8ZqD/M6rTpeScuolt/1u1cp+kzhQc0jwaiw3ESjho4JBl3sKiaQqfI0gZzF5wF69W0IoNpB
        O4XyLL5osl2JpgwJSJxIo1FbTSGN8rucNHrbJkdGc5IEiU+fkKi1zkCgx5d6GTQsTkhQ44U6
        AtnKSiXIntZLoJyBOwzKHftCIYOlDyDRmkuivsxhBg2MNFGbFuJ3Q78obLpmAjgl+TyNi1qG
        aJyV/JnB120jANv03QxOsXcy2GBNxGLpctw5uBFbb6fT+POzZwxuuvKDwu/b8wnc6xCpUO99
        sg1RfHzsEV63JiRSFvOpKuJgrvTYT/NNOgncYDKAlIXcevjRZiAygIxVcLcAvHju/l+RTsCG
        7OekWzQDaK65z7iFCKBzPIt25RXcYnjmlpF08TxuC6zOT5nxvbn9MPPdOOUKkNwkAzMqu4A7
        nUrAgkepM1M0FwhHB6una1lWzoXAotoQl01xS6B5rEviYh8uDBpL+mdYznnB79k9lIulHIK9
        jXbCFSWna3JyNC6b5Hxhcuobys3+UDQNk+5/KuFI91uJm7Uw0/mVcrM/7DfeIy6B+fpZG/T/
        W/WzWvWzWg2Aug28EwVBE60RglcLao2QqI1efSBBYwXTB1b1aFysBu1nQh2AY4HSQ15hMYYr
        JOojwnGNA0CWVHrLmR5TuEIepT5+gtclROgS43nBARawlNJX/mLO2nAFF60+zMfx/EFe9++V
        YKV+SWBDsHbrduuxFo9leR6j+yOi7IF7VEJF3MCioWGfsPKaACITPRy8Ky9YVdLRORXIUV5z
        FaqYIn9R9rosv9hSG9vqOBv7YOED28ptm6UlLy+vPLpzF7Z4eq49+SGoo94WucK87mp6WP34
        XqcqZqlXXWf9Dru66lTx1psBqkP9RUavp0pKiFEHLyd1gvoP18NkNlwDAAA=
X-CMS-MailID: 20180927135842uscas1p2bcff0065e45b80ad107288e9b1ecf241
X-Msg-Generator: CA
CMS-TYPE: 301P
X-CMS-RootMailID: 20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416
References: <20180918135328.32034-1-mathieu.desnoyers@efficios.com>
        <1367962117.10271.1537897176578.JavaMail.zimbra@efficios.com>
        <CGME20180927132250epcas4p3d0775cc258f6112d27bdad359fc6e416@epcas4p3.samsung.com>
        <20180927092235.77282e35@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 07:22 AM, Steven Rostedt wrote:
> On Tue, 25 Sep 2018 13:39:36 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Sep 18, 2018, at 9:53 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>>
>>> On x86-64, the parametrized selftest code for rseq crashes with a
>>> segmentation fault when compiled with -fpie. This happens when the
>>> param_test binary is loaded at an address beyond 32-bit on x86-64.
>>>
>>> The issue is caused by use of a 32-bit register to hold the address
>>> of the loop counter variable.
>>>
>>> Fix this by using a 64-bit register to calculate the address of the
>>> loop counter variables as an offset from rip.  
>>
>> Should this fix go through tip or the selftests tree ?
>>
> 
> I usually have changes like this pulled through Shuah's tree with an
> ack from the maintainer of the code that it tests.
> 
> -- Steve
> 

Right that is what I prefer. I usually wait for an Ack. I can pull this
in.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com
