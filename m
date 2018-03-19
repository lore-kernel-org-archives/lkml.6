Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AG47ELsQxrvGc4mFjPMHx+Q8AWJdHi2w/ikxCWEtSjZoTTliqidsLX4PteiYttk61lQhCZewJkFI
ARC-Seal: i=1; a=rsa-sha256; t=1521472800; cv=none;
        d=google.com; s=arc-20160816;
        b=nGeyeXopYV8fvKaamW1gepHHk1XNkXEvVhTH/wkOB/h34rquu7xUaBp25jI2oBIhS+
         9TtOXu20nZeloHZtbMVlE1zjkBJ3gEWXd/Bw1jATtyLw27hdibuu+KQ5X+aqTnoq3tsY
         r/nUYwCktKjBNxKs8uuYMKryNf+A8A3X6DVSFdCZZ7J6yCIwJ11WO8NfTA9Vwbz4eMz2
         QlTG+mjJr2av5JwIX66XFr/vwPrJ1L00BodJuhKMK1VpN0/55Sgs8Pwg6Mav5f5dPJFi
         Kz3MJX6m+UqzfPkVz3/dq/7LAhBSad4uVMMYvrpEXhgoifqlkQ2OBVCMh593Tv/vPyJX
         t6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=49kIbFTiRo+yxw75mbqaRoFhkWLySa7MlihvqQtfG6E=;
        b=t4kggajqV+pGPh4skc2ZdmCWIOR1h+Zzn5hLMVLmT0btU/BT9IoplMwrVzuMu6mMac
         hwf+zfp7gwJag+ArTgbQNNgRtBv3xvPmUrawFvkQxpuTCI2R0CI7Yyh1jOo6pzk2Xmsz
         DMaLVNlGX9kQxmoItDuV6OZf2PVmC+drU0ELBRjpZbY0bxkW/rq1LIoT5zPkbr9ivXLZ
         tgP3b02jgZO5alX1fPx7vdSP294nROUrw+4mDqhj8qBwqhG0KOox3QVZGTE960aV8cQG
         0KKcMgXfoq1vCU5hvHjAfh9kBY8sCKFmO+1qIDG4xw0uckBYCsWsoCfETWlIo7tHDhXm
         Nifw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tfUdP7Ni;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tfUdP7Ni;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature introduced
 by SPARC M7
To: David Miller <davem@davemloft.net>
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, allen.pais@oracle.com,
        aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com,
        arnd@arndb.de, benh@kernel.crashing.org, bob.picco@oracle.com,
        bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        dave.jiang@intel.com, david.j.aldridge@oracle.com, dwindsor@gmail.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        henry.willard@oracle.com, hpa@zytor.com, hughd@google.com,
        imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
        jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
        khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
        ktkhai@virtuozzo.com, liam.merwick@oracle.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com, linux@roeck-us.net,
        me@tobin.cc, mgorman@suse.de, mgorman@techsingularity.net,
        mhocko@suse.com, mike.kravetz@oracle.com, minchan@kernel.org,
        mingo@kernel.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <20180318.110857.1660518649370410007.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <b9507686-6c3f-7fb1-b305-c1817f86a884@oracle.com>
Date: Mon, 19 Mar 2018 09:19:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180318.110857.1660518649370410007.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=832
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031775429403993?=
X-GMAIL-MSGID: =?utf-8?q?1595379863210878885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 09:08 AM, David Miller wrote:
> In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
> CONFIG_SPARC64.
> 
> That's not correct, you should never control user facing definitions
> based upon kernel configuration.
> 
> Also, both 32-bit and 64-bit applications running on ADI capable
> machines want to compile against and use this informaiton.
> 
> So please remove these CPP checks.
> 

Hi Dave,

That makes sense. I will send a patch to remove these.

Thanks,
Khalid
