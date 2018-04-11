Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDKGNC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:13:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751661AbeDKGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:13:01 -0400
Subject: Re: [PATCH v2 1/2] trace_uprobe: Use %lx to display offset
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org,
        wangnan0@huawei.com, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com, mhiramat@kernel.org, namhyung@kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 11:42:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041106-0008-0000-0000-000004E920B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041106-0009-0000-0000-00001E7D21DA
Message-Id: <e56cfe4e-24cd-e01d-899b-a2862a6afd66@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110059
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Can you please pull these patches.

Thanks,
Ravi

On 03/15/2018 01:57 PM, Ravi Bangoria wrote:
> tu->offset is unsigned long, not a pointer, thus %lx should
> be used to print it, not the %px.
>
> Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> v2 changelog:
>  - Keep prefixed 0s as is.
>
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2014f4351ae0..0298bd15be83 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
>
>  	/* Don't print "0x  (null)" when offset is 0 */
>  	if (tu->offset) {
> -		seq_printf(m, "0x%px", (void *)tu->offset);
> +		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
>  	} else {
>  		switch (sizeof(void *)) {
>  		case 4:
