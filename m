Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELuGVBN7oaZ4MMZowbwGjOsruLPP5bim7hwJuaMIpvyfQiSepyDzDPqKhDyqmYwdkcXAd2mQ
ARC-Seal: i=1; a=rsa-sha256; t=1521190344; cv=none;
        d=google.com; s=arc-20160816;
        b=HJ/fuVe3p79hGBuNCn2KlFTgQQF1mb5YUm2DKLz27x28j9Tzf3XxV4ZEm8QxA0j+vd
         aN69EG9W2SfGgg3D2LxIKs2b8xzXPqxQjUCFyCwwnrYnB9b3kv9Mb2l7EwFxX+cJYSEq
         jOJ43tKclHhUDG6yR0EgzSbEHjkMYClphuzGxZX+dyT5qDEQu0jGfklhAMWMd/hd3Emz
         g1rL21jVVJl1A9+k4uj4QiI4J7Ysgfm9yGUnqdqnqTjTdzAcIBwT6KCVoRYRy9QOKTVG
         5sryqbjtZzbZbTN5C555vQqp/BpdFarwoTm1OD+wu7A2KLpIDw9S4wt9+0ItW262OJtz
         xEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=IdjPcvOlGwGEZtuWTGxN5Kwmc79e+lpZ3DS35HJS/A0=;
        b=vVIogkYfgw9W8dCqTQ80kURpHexHQn/z0O4lflbX1Q6QFLOJkwQR7YJz27I9AEzKY+
         cuhrO/xPgILCmXPpAz5V3/sIxSnY4xgtJ6trzg/QvU2eNdKCbRr9OqZN++iWOS0LyS5h
         5AKIxsK4RS14I1MDHxvcYDJYC0h4TgPC8kHW7D37+mnQfmf8VXqxWKD1W31f/zEOdzqm
         IJOBW6GZ/BkPGqFfb+KCLcXGg2qMMVjykLrorymB3gLUJ1q2LfHtcCIsv5AHZ7dMjkLp
         FDMyy8ZeBa5bi+FxVhUtHgqS0uH/UQV3iiZesgGpbF0Z2z4uQlaYCKAeu//fQfXNoe8h
         HTpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 1/8] Uprobe: Export vaddr <-> offset conversion functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
        jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com,
        kan.liang@intel.com, kirill.shutemov@linux.intel.com,
        kjlx@templeofstupid.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, milian.wolff@kdab.com,
        mingo@redhat.com, namhyung@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        pc@us.ibm.com, pombredanne@nexb.com, tglx@linutronix.de,
        tmricht@linux.vnet.ibm.com, willy@infradead.org,
        yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180315122753.258c38df@vmware.local.home>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:24:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315122753.258c38df@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031608-0040-0000-0000-00000421D544
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031608-0041-0000-0000-00002624E14E
Message-Id: <6719969e-fd4c-55eb-0052-04e62de1b02e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160109
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827116225046806?=
X-GMAIL-MSGID: =?utf-8?q?1595083686855404226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 09:57 PM, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 18:25:56 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> No functionality changes.
> Please add a detailed explanation why this patch is needed. All commits
> should be self sufficient and stand on their own. If I were to come up
> to this patch via a git blame, I would be clueless to why it was done.

Sure Steve, Will add description it in next series.

Thanks for the review,
Ravi
