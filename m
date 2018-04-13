Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx4+xlxVk0SJWO3qnt3rStkKhWN+Eg8tRl4sv0dbrVFM+uSKI6DPBJf3UMG+mjayvUNkERJXC
ARC-Seal: i=1; a=rsa-sha256; t=1523624877; cv=none;
        d=google.com; s=arc-20160816;
        b=wWi3Wc85paKcCJ0lwk2i3qONUPHQavFhmSfCozkDEouBxDAdq2WBsg7Gfv/0KCXbnI
         NU386/2aJL3zJa1HS+BtBYYCe5tYVaDypS1Al+ErNtdT96OowFbZDyi+eE4jBquuB4AS
         nEBob+Rm58voj63Jz6nkHn9cEcWiJLkou4S+wl1KKTxujemmXW6XcANMtfcRjtrK86Pz
         DqQFULh0OBK9S0m2RdU3IWb6vIi4IMfLwMOH9tOpkLWmmFV/S4+Ed6jI1lWW1x2oT46J
         H5/apCZb1UqOQQb7YKHxwrF3FTYgrFlKSoU9pjvkOtTUsH9l6KbjN7IB/18+lIhpFJBd
         lLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Rgzg0eTZImnq8P1GVulNwrs/L1/7HhFo+PotcaMl0oE=;
        b=RirIy0NxIMkPp8Rf2sLPH9R/jYJa7T9f8Yo3wTJzZ2eDJ+dtVI5x8tXvQoXs5CQhfo
         pCUQ2tNFoApt7LSj+a3v7bTFUHc4FuDje1wAfqHRmAg5efcjrLPbfbQ71h2UCfwPFJ77
         w11rx7XsR1D4xgyL6S4pDjM6HoHPBDrV9fdt4BhC3o1IIZUH8jzOCdyNGUcG4YdE0aQa
         e88KmRfGO3L8u1C/riLj8edoWX2ePnzOmsN1XGCahNb+RtWkzU1t0d+Fr2v6BAwg0TZZ
         iBgttkSgFUWSC91yReNjGL6sH1YOGX71D3N1E4jdFgS1KZKAnP3cASuxp6egqvtrmPe9
         HRvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizf@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 0/2] tracing/events: block: bring more on a par with blktrace
Date: Fri, 13 Apr 2018 15:07:16 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041313-0040-0000-0000-0000044D34C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0041-0000-0000-000020F16D35
Message-Id: <20180413130719.22921-1-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130122
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636479596160991?=
X-GMAIL-MSGID: =?utf-8?q?1597636479596160991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I had the need to understand I/O request processing in detail.
But I also had the need to enrich block traces with other trace events
including my own dynamic kprobe events. So I preferred block trace events
over blktrace to get everything nicely sorted into one ftrace output.
However, I missed device filtering for (un)plug events and also
the difference between the two flavors of unplug.

The first two patches bring block trace events closer to their
counterpart in blktrace tooling.

The last patch is just an RFC. I still kept it in this patch set because
it is inspired by PATCH 2/2.

Steffen Maier (3):
  tracing/events: block: track and print if unplug was explicit or
    schedule
  tracing/events: block: dev_t via driver core for plug and unplug
    events
  tracing/events: block: also try to get dev_t via driver core for some
    events

 include/trace/events/block.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

-- 
2.13.5
