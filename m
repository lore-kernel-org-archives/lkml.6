Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeEGVe5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:34:57 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:38296 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752858AbeEGVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:34:42 -0400
Subject: Re: [PATCH v2] perf tools: allow map files to specify DSO
To: Andi Kleen <ak@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <1525717456-21475-1-git-send-email-johunt@akamai.com>
 <20180507184001.GE4050@tassilo.jf.intel.com>
From: Josh Hunt <johunt@akamai.com>
Message-ID: <e6272e7c-25fd-0d2d-4199-fcf3ec604546@akamai.com>
Date: Mon, 7 May 2018 14:30:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507184001.GE4050@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=853
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070211
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=835 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1805070211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 11:40 AM, Andi Kleen wrote:
> On Mon, May 07, 2018 at 02:24:16PM -0400, Josh Hunt wrote:
>> Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
>> The DSO should be the first line in the file and readable by the
>> running user. If a valid DSO is found all other contents of the
>> file will be ignored. This allows things like callchain unwinding
>> with DWARF to work.
> 
> FWIW it's ok, but also obsolete with Kirill's large-pages-in-tmpfs
> work in newer kernels. With that you can just copy the executable into
> a 2MB tmpfs and disable the manual huge page copying and everything
> should work as usually.
> 
> So essentially it's only a hack for old kernels and old binaries.
> 
> But doesn't hurt I guess.

Ah, very interesting. I wasn't aware of this. Can you point me to some 
more details on this process?

Thanks
Josh
