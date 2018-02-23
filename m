Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x225QUEDkKOWSXuF8gutUjgC7iKEkuUuBkZBLwh9NQ1oVsexd4bMdgROu7mgnX4wexohw76U9
ARC-Seal: i=1; a=rsa-sha256; t=1519423909; cv=none;
        d=google.com; s=arc-20160816;
        b=QaH9yLx3ELtWW/dR2hLkFZs0y+SNP0MqobvkJ+XYvnhpjqH7cP0iIuzPqPV77ZtlVw
         SOnDcn5is5ePY9w3hN64SpgYn4B5HSykN7V2yejM2e+MIOMfNqC88oMWGHgbFH85Xjea
         3CFQjp3jSHPseIKtJKGqN/TqakI8o0y0e7mJeQ7ouGUy/5AowppqadwT/oF0WzjjGYyN
         zWTAFO/X4z/3rvxiH3ye/c9WZuLEWs0aTCcQ+IQM2+VBeLD0LqlRdygA8iapB3n3CGxb
         3v2Zi4dhsxKGAw94xbGHtnQrG2E0xGBMsVL6DY92lQ6sXX33g4Gxo1o6+STk8PlK1vdz
         8Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=3h4brh0SBIMdbgrC6l1qw3MBelArmAy9bbc9uYdhTuw=;
        b=wbYzl05hQDv9q6eS5WFyGPxs0nNw5yxK/no0paD2K49UQzjQD3WW2A0DIKIuMWxbwi
         pPglJGwO4FGSlTRS9YQFGVtPax+Bs1bOqilPVFEhavLhAnp7eYCG2+8VYgiCz5BuRwlb
         enh4D/MVZ4PU2UfIulevB/b+irWnH3MMapGLwTKrVHU2ig2x/fCM7fr0jOG8CjuCIv3K
         pPBuUZzowuA/IEXWO0Vxf+wPAicw21PoDsYKSASiIWz6GZYXq55kk8UcD0/qoWw8YZpp
         oNuqcWlv/QRzWR2sq2nBTBSqpGUWd5nidF7Dtslz5VgeU0MiZnEXp4/XKCZaXR4QOtRA
         FXGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=mDhjK6ge;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=mDhjK6ge;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, corbet@lwn.net,
        steven.sistare@oracle.com, pasha.tatashin@oracle.com,
        mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org,
        nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com,
        kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com,
        allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com,
        vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz,
        punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com,
        ross.zwisler@linux.intel.com, dave.jiang@intel.com,
        willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com,
        aarcange@redhat.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        nagarathnam.muthusamy@oracle.com, linux@roeck-us.net,
        jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com,
        ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, khalid@gonehiking.org
References: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <201802231005.WSf8KcHd%fengguang.wu@intel.com>
 <490b8c3b-fc62-b6e7-af28-7c1257e953ce@oracle.com>
 <20180223.135716.511559214062584207.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <7223b9b5-c05a-8ade-beaa-e7e82cc8ea01@oracle.com>
Date: Fri, 23 Feb 2018 15:11:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180223.135716.511559214062584207.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230268
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1593231445310491746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 11:57 AM, David Miller wrote:
> From: Khalid Aziz <khalid.aziz@oracle.com>
> Date: Fri, 23 Feb 2018 11:51:25 -0700
> 
>> On 02/22/2018 07:50 PM, kbuild test robot wrote:
>>> Hi Khalid,
>>> I love your patch! Yet something to improve:
>>> [auto build test ERROR on sparc-next/master]
>>> [also build test ERROR on v4.16-rc2]
>>> [cannot apply to next-20180222]
>>> [if your patch is applied to the wrong git tree, please drop us a note
>>> to help improve the system]
>>> url:
>>> https://github.com/0day-ci/linux/commits/Khalid-Aziz/Application-Data-Integrity-feature-introduced-by-SPARC-M7/20180223-071725
>>> base:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git
>>> master
>>> config: sparc64-allyesconfig (attached as .config)
>>> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>           wget
>>>           https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>           -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           # save the attached .config to linux build tree
>>>           make.cross ARCH=sparc64
>>> All error/warnings (new ones prefixed by >>):
>>
>> Hi Dave,
>>
>> Including linux/sched.h in arch/sparc/include/asm/mmu_context.h should
>> eliminate these build warnings. My gcc version 6.2.1 does not report
>> these errors. Build bot is using 7.2.0.
>>
>> I can add a patch 12 to add the include, revise patch 10 or you can
>> add the include in your tree. Let me know how you would prefer to
>> resolve this.
> 
> You need to update patch #10 so that your patch series is fully
> bisectable.

Hi Dave,

That sounds like the right thing to do. I am updating patch 10 and will 
send out v13 for patch 10/11. Rest of the series is unchanged but I can 
send the whole series if you prefer that.

Thanks,
Khalid
