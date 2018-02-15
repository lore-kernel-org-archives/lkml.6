Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x2258tC3b3RpMEOsDCsPERCu+oPtpjYYwhLpbxEbNZsqD6WwkwzcobY/j4HIZI8ZJAYgUj2zJ
ARC-Seal: i=1; a=rsa-sha256; t=1518663300; cv=none;
        d=google.com; s=arc-20160816;
        b=n8D8Z6UWR/9ItxfSmjh2kSB6QM+mpBzpWSQWXcKtjcr9Wp8QpP5I2bvTsjR1q1jL/m
         RLd8+WPOhHh4PjQXw9YrAuzUfCFzKJxV6wCvesIWeLvpRh4Vo3NUcOkWg3te/h1tR8SO
         FvGqCjavCKnbTxEPHbFFcwkyu2Kz84BfIrpFWZRNw7ETeBn8KwE+pDTSRQZty7tkbrhW
         lCUDQrmID1PzzqW9GefZXN5IRoGWuAU0YZ1KvyyD8XMD7xJV/MPVB1/fkipVXBYhNyTU
         Yfw3HU5P9A4grose0sEYr5/vw0VvHUqOYa3hZoixeP5igGsGMcYwpdoKLcqGlhFV0Ik2
         dFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:from:references:to:subject
         :arc-authentication-results;
        bh=27mpGaHOYSOUHchMtMRcU6rGL+cUdz7afTZpJABs+h0=;
        b=sJLPSsbvscjndSbe3DMyfXyiFqJ05ykJXdK6WlX+n1/aZnO9SWl85y9NF4q8fpIwby
         6Im+LME8Wo+/c10IqfzzeENuSL3h4PUEkzLrPPxZkYH8f06zr3RUfQXuylNHCizG1FLS
         hiyRtNQ1RF+TcF3Q32WLl0pHCXjGPPTQpoEY8ap+ZvVzuLTHwBsLslEgNM2FgM1JDZXX
         rjCAN/FOvMXTLJsYdh1z2gj/oJJLBcdlGt2cbI6a4RWLCQbieOGaCnBlD48AIWBkFJP9
         zQsh8BVyIPUniz/3v6pJSLEizO3ti39bzN/vRkGu5SN6PTPSXBexYnBzzM4N3dqqpkJI
         Wr6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for LSB
 encodings
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
 <1518624228.3147.4.camel@wdc.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 08:24:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1518624228.3147.4.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021502-0040-0000-0000-0000040FDA11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021502-0041-0000-0000-00002613A2E3
Message-Id: <f4abe1a9-e128-ad68-8a4c-1034eabcfc1d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150035
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592433888767607891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 09:33 PM, Bart Van Assche wrote:
> On Wed, 2018-02-14 at 10:28 +0530, Anshuman Khandual wrote:
>> +#define SG_CHAIN	0x01
>> +#define SG_EMARK	0x02
> 
> Hello Anshuman,
> 
> As you probably know constants that do not have a suffix are of type int. Please
> consider to add suffix "UL" to these constants to avoid that the compiler could
> take an undesired decision when e.g. converting ~SG_CHAIN from int to unsigned
> long.

Sure, will do.
