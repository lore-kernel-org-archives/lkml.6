Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELv5TmtsQrYhFn1Gt2Cca0/b5YpbxiqI7odrB+iel4YcUK7YKlS7Y3xM70IIkphbMvJeGBGm
ARC-Seal: i=1; a=rsa-sha256; t=1521190640; cv=none;
        d=google.com; s=arc-20160816;
        b=QE5jtHh8gRV8Z5UThC/vUTqG08YGMCfX7sK/s40mmmSbxyH8zVZH9B80dywE3o1JIV
         gZLabVJNtpCR1SEH8/LY0+1GuOiLMWs9sC3bPZo2ilUJtYksHTwRk3NtMTbdHl0D4AtJ
         m0BOgEh8evoAI0C66Vj0k9oHYEgIHyEyr+2yDRjFMXo655/Gyxyjt2VjtaEShwRaj/p5
         AHY+QhWiLP9ZrIEIZePRTHCC1ECBV3YszpA+1xxW0QXrxtStxX1N0M++86520TAIXodS
         pl5ov4dZdC3X/8J9V+wDjeJ0ygxJf1Nan4PoWNdmEz0dI5QqlWQpgq/HCBTgUg6xfo9W
         GeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=5ZWkYHrG9fN2fPsQ6Nj145IJQZIL9cBI12HHKsgxjsM=;
        b=0r0p43bjtnU6D3nuR+HlNM6usuAjpRsNFcFgTKJt213TantiFgjlb7cYuiAprH8wmZ
         XYdBpnNKfJEBtT7tab66/xxjcdXWGzZeORUijuhAuSAxWY4baYX1SHHts8DKjdnn6D1O
         Y2SvHi/pI3FdzneSrsYLJni8CzRdmqxk6w1pv+f3+TBMY8D46Medj0OwbjWO+r8EA9sA
         rcvXytfaZU633WVXePzo0OkdJ81+SR6nCHBEUX7JxXrehDyP+npIBBEdoyH55/JRiyMG
         IZ7Pq8IBokOSbd+CzDKagoeaq5T8AIRpuZJRznpYNvawotavKPELauYQ88986dqbwarB
         1fTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 4/8] Uprobe: Export uprobe_map_info along with
 uprobe_{build/free}_map_info()
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
 <20180313125603.19819-5-ravi.bangoria@linux.vnet.ibm.com>
 <20180315123255.17a8d997@vmware.local.home>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 14:29:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315123255.17a8d997@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031608-0040-0000-0000-00000441D761
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031608-0041-0000-0000-000020E4E4E1
Message-Id: <635d8d6d-0d2d-98a6-5fe4-44185aa560d8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160110
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827156987945249?=
X-GMAIL-MSGID: =?utf-8?q?1595083996777461641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 10:02 PM, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 18:25:59 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> These exported data structure and functions will be used by other
>> files in later patches.
> I'm reluctantly OK with the above.
>
>> No functionality changes.
> Please remove this line. There are functionality changes. Turning a
> static inline into an exported function *is* a functionality change.

Sure. Will change it.

Thanks for the review,
Ravi
