Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeEHNgH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:36:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeEHNgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:36:05 -0400
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
 <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180508090756.57f38d17@gandalf.local.home>
 <a5578a08-2434-af48-7910-6f858e5477d6@oracle.com>
 <20180508093459.092988b6@gandalf.local.home>
From: Thomas Tai <thomas.tai@oracle.com>
Organization: Oracle Corporation
Message-ID: <24ef86b8-20d9-d654-2af5-159659a9eb76@oracle.com>
Date: Tue, 8 May 2018 09:35:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508093459.092988b6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-08 09:34 AM, Steven Rostedt wrote:
> On Tue, 8 May 2018 09:25:01 -0400
> Thomas Tai <thomas.tai@oracle.com> wrote:
> 
>>>>>    	TP_STRUCT__entry(
>>>>>    		__string(	dev_name,	dev_name	)
>>>>>    		__field(	u32,		status		)
>>>>>    		__field(	u8,		severity	)
>>>>> +		__field(	u32, 		tlp_header_valid)
>>>
>>> I'm guessing tlp_header_valid is just a boolean. It's after severity
>>> which is just one byte long. Why not make this one byte as well,
>>> otherwise you are wasting 3 bytes.
>>
>> Thanks Steven. Yes boolean is fine.
> 
> But don't use "bool", use u8, as bool can be various sizes on different
> archs.

Sure thing. Thank you.

> 
> -- Steve
> 
