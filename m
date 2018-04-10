Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeDJEpQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 00:45:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbeDJEpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 00:45:15 -0400
Subject: Re: [PATCH v5 0/6] enable creating [k,u]probe with perf_event_open
To: Song Liu <songliubraving@fb.com>
Cc: peterz@infradead.org, rostedt@goodmis.org, mingo@redhat.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Oleg Nesterov <oleg@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20171206224518.3598254-1-songliubraving@fb.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 10:15:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20171206224518.3598254-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041004-0040-0000-0000-0000042C6522
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041004-0041-0000-0000-0000263071F4
Message-Id: <97e2c641-9dfe-bf7c-9043-c79fa0c568f9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804100049
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 12/07/2017 04:15 AM, Song Liu wrote:
> With current kernel, user space tools can only create/destroy [k,u]probes
> with a text-based API (kprobe_events and uprobe_events in tracefs). This
> approach relies on user space to clean up the [k,u]probe after using them.
> However, this is not easy for user space to clean up properly.
>
> To solve this problem, we introduce a file descriptor based API.
> Specifically, we extended perf_event_open to create [k,u]probe, and attach
> this [k,u]probe to the file descriptor created by perf_event_open. These
> [k,u]probe are associated with this file descriptor, so they are not
> available in tracefs.

Sorry for being late. One simple question..

Will it be good to support k/uprobe arguments with perf_event_open()?
Do you have any plans about that?

Thanks,
Ravi
