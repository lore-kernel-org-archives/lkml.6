Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZpffa/mbdULNZpgPb02OuUKRVwwJ1x/4yi6j5Jazh4LRxig4+e/g2OjPe/5Z1SN6EKCJdXN
ARC-Seal: i=1; a=rsa-sha256; t=1525740032; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9jgxF9uKuEjV534o+JsbYlxSrDj49Yk/In26bp7fl9Wtz5na9P+qgAv6YDx/CW4fk
         RRYqr6jnZgN1gvJTvyXj35E6Orb6yjJWFDDx8Xe1wep8rdWJcbBQ5/n1GVOqyc1VMHzF
         qMFpcEoQ1VWD5o4wk8pc6/r1F3gmr/evXRAL2XWro130LKtZlJOXBij8HL7BcEwzdzZE
         jtwyb0B08w3JtkrJAT52a0oAlBuwDDy4crLR+8IJJoEE2LdAJr6wvwj6AGL9L6UOklV9
         mYt4OXS02AABM8eiHhgLgUmpYB4wmRRCqehMmmE+UXkuFblKSIioqXaY9Xks28prgSyQ
         eRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:organization
         :references:in-reply-to:date:cc:to:from:subject
         :arc-authentication-results;
        bh=7+ppsqTlTyn0n62mOz/GiPz9bGT/7p/ZiTgl8XJtRrE=;
        b=IDjLvVYWFLVSpPh6WdUesF3rxq1vGjSySXQCMm66E+ExW0Nq2Fn9tAYBIppF3s27Cq
         kbelVcnjxMHOIbkOwMW2RfAwwmG9WZdSN7I8klqdFM5Pd0+fJ0yRUn/wn3q8bBZILO7G
         VfrTX03cMDq+zX/0lX6Pu2y9pAmsj9LMtDShv5iXZ7spHiH3Qrqn7GxF5hzMVq5ylLKo
         b9qoWC8jdXQFwYyivxWD/hVuxnH4he2rT0UkXZ+fd15PL7YVvKK4tNZ9AGLbdPAoz9go
         sbpggIu737GIZo60UewejzAnOPpy73i9FkdOleXYb+7L2DmX1qXKYs4Hc837M7mBSnxC
         1Ynw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 3/7] powerpc: use task_pid_nr() for TID allocation
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net
Date: Tue, 08 May 2018 10:40:21 +1000
In-Reply-To: <b8aa28c4-9171-cb7f-9a43-22f2f15657b0@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
	 <20180418010810.30937-1-alastair@au1.ibm.com>
	 <20180418010810.30937-4-alastair@au1.ibm.com>
	 <b8aa28c4-9171-cb7f-9a43-22f2f15657b0@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050800-0008-0000-0000-000004F42474
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050800-0009-0000-0000-00001E886232
Message-Id: <1525740021.7796.45.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080004
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550726280592?=
X-GMAIL-MSGID: =?utf-8?q?1599854379952123532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-07 at 19:37 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > The current implementation of TID allocation, using a global IDR,
> > may
> > result in an errant process starving the system of available TIDs.
> > Instead, use task_pid_nr(), as mentioned by the original author.
> > The
> > scenario described which prevented it's use is not applicable, as
> > set_thread_tidr can only be called after the task struct has been
> > populated.
> 
> 
> Here is how I understand what's going to happen if 2 threads are
> using 
> the same TIDR value, which is possible with this patch (if unlikely):
> 
> 1. waking up the wrong thread is not really a problem, as threads
> have 
> to handle spurious wake up from the 'wait' instruction anyway, and
> must 
> be using some other condition to know when to loop around the 'wait' 
> instruction.
> 
> 2. missing the right thread: if the wrong thread is on a CPU, and a 
> wake_host_thread/as_notify is sent, the core will see a matching
> thread 
> and will accept the command. The (open)capi adapter won't send an 
> interrupt. The wrong thread is awaken, which is not a problem as 
> discussed above. As the right thread to notify is not running, no
> harm 
> is done either: as soon as the thread runs, it's supposed to check
> its 
> condition (which will be met) or call 'wait', but 'wait' immediately 
> returns when called the first time after a thread is scheduled.
> 
> So I believe we are ok. But I think it requires a huge comment with
> the 
> above (at the minimum) :-)
> 
> With a comment:
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> 
>    Fred
> 

Good point, I'll add this in the next revision.


-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australiamob: 0423 762 819
