Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x224JyTiwTqvSQNvwuqzI0Ry+Ii4ShkmblW2udL9Ba8U+uvB2TXGK5zPXdo92TRaoAYipS1ER
ARC-Seal: i=1; a=rsa-sha256; t=1518663201; cv=none;
        d=google.com; s=arc-20160816;
        b=Ci+HMcOiP6yJMrljMzX0GHvJprWAOQIg4w02jEeiBAJbZY1RJiLeH5Xb9ZURJtDx/N
         LTekkGlT4nCnXXtkT0uZ00laJKBAzwFxLTuNta7Bv9NJyBUfx+hUNki4Dz21oj+H79Lk
         V9j90wLZ8BKAjTzkOAudiVMGVCgs2+mMev5oq2to0Bwt9rd40GEYQCwnmZ/0MoCnTjDj
         7e102+IefPGhdhqBIe8kbW+tUxeeF5JQJcM2Rd2ObbecL4pSYub1E2Z6UPJtkocHyJxT
         GOeaJi6eGtTDaFI1zuLP9+OaVFKm49DvRzDoTdl7waxOQ9ByY9IWw3Qq6oj8q4OzIprZ
         lXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:from:references:to:subject
         :arc-authentication-results;
        bh=BlLUbOHptSiNjYI54APrVtDDjvHDTEeGvK9murCj2yU=;
        b=B3qi9yASF6CN47w9ZGaM3EiSKsa3Jm++IOx8FIhE+n8aUoNeEs2sPohOuhVDJL3s7Q
         Vwa0ak84qGiolPsO0JssFEfc7UCkoa4hA/10abE9FmbXdS2Y67MdZLGFfsqzCzqFmYIG
         siBqqdHClCVv5oJ+nTnExoNFf9EEyt5i7KOpYDMU/qFuJAUOzWYA/jmgUNe538g8vGSE
         ir622IcfZ5rzvoP0/mnsOM5jvvgtKPuX7u06WOy2QqyCr4SH8rIi+oVPOZvvTgwC3K/V
         JLlF66lhYsc2006XhmS9B840VhWv/I88nwtjl/5nWhMxmqAUhT2oo2U3/n/BqoCuMcRC
         A1cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for LSB
 encodings
To: Tvrtko Ursulin <tursulin@ursulin.net>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bart.vanassche@wdc.com, axboe@kernel.dk,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com
References: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
 <1518597168.24629.4.camel@suse.de>
 <ebbfc01c-3f42-483e-a281-1b4572bc8ac2@ursulin.net>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 08:23:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <ebbfc01c-3f42-483e-a281-1b4572bc8ac2@ursulin.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021502-0020-0000-0000-000003F5CB7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021502-0021-0000-0000-000042885CE1
Message-Id: <df1466af-c145-5225-c71b-9e0977faa98a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592433785947124901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 09:41 PM, Tvrtko Ursulin wrote:
> 
> On 14/02/18 08:32, Johannes Thumshirn wrote:
>> On Wed, 2018-02-14 at 10:28 +0530, Anshuman Khandual wrote:
>>> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
>>> SG_EMARK definitions without any functional change.
>>>
>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>> ---
>>>   include/linux/scatterlist.h | 23 +++++++++++++----------
>>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/scatterlist.h
>>> b/include/linux/scatterlist.h
>>> index 22b2131bcdcd..63d00bdb2fb3 100644
>>> --- a/include/linux/scatterlist.h
>>> +++ b/include/linux/scatterlist.h
>>> @@ -65,16 +65,18 @@ struct sg_table {
>>>    */
>>>     #define SG_MAGIC    0x87654321
>>> +#define SG_CHAIN    0x01
>>> +#define SG_EMARK    0x02
>>
>> SG_EMARK sounds strange, what about SG_END?
> 
> +1 on SG_END.
> 
> Btw, just a cleanup for readability or you have further work in this area?

Sure, will replace with SG_END. I was trying something else on virtio drivers
on POWER platform and just came across this. 
