Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZo0fiRkhFUm4WlozXxXOfQ6G4DKfe8n0lS5PWO6p55MZt9IivCwgnCnvwT30S85kpWzczFV
ARC-Seal: i=1; a=rsa-sha256; t=1525103404; cv=none;
        d=google.com; s=arc-20160816;
        b=G37DcyGbJeA2j92ECUJKg+3QCEzLGqJiSxVY7ByVNQrh6M0gDP9SqlX09u0dzRBW0P
         oznkzlDX/03qlB0TD9f0vC5hSCdojhy9ts8nLGsdzs2x7h44So/SJjc+vh+JqFva0HXT
         L8u/4RMqFm122t41FwWiliqh6S6+OmwcuGQ8RPP3TL1s90UA0ks2Hk5bpfju07xcbREL
         /9uLqrV0He3XmkMpjnJSg4UYHZgImEHy1PLQmkM0aS41bE4JZ6TS5NNEtoQB48W7jJtg
         kDTJCD18zFNTwhJivtFcpaBSpPY8ubQwS3lhokRf/jpK6pjFI522HGL3C//YSp+ndDwd
         TFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:references:cc:to:from
         :subject:arc-authentication-results;
        bh=pcMTY9Gr4ts/c8rlPNxhmDDKCfwYWpN4Au8aMU2XMg4=;
        b=TRGYLqXAjy/gYUrgccSajt37gIevKGGsek/q4jEuCZzsCqZi4cHnF2Xy5sdtZ8eOr1
         6fzCFixmidO2XmT4st3ru+TEpRjOfr1nga1Z7HEWPpATzBAcn2o9QA1gwmqjvvdzKWXV
         YiqTFwnbH2Ka4GGdRsqavEJaUTUn3Jgc4w4dOysAEH2zthqsmfx893h/wEkz+PghIAuU
         CnzcBas5BgUYjXsN3Z0OeMPTO0f7iure8lr/qwHh9X/RIpG5GBorBQBnA10bOecyiFI/
         tovnRT/pSEv/ilNKhW/rnbEnklOo0QqTZqNlCIJ5/Rts7ROtdg4fzeQ8yNT9UkLeVjrS
         nmkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RCFv2 1/7] mm: introduce and use PageOffline()
From: David Hildenbrand <david@redhat.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams
 <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 Jan Kara <jack@suse.cz>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>,
 Souptick Joarder <jrdr.linux@gmail.com>, Hugh Dickins <hughd@google.com>,
 Huang Ying <ying.huang@intel.com>, Miles Chen <miles.chen@mediatek.com>,
 Vlastimil Babka <vbabka@suse.cz>, Reza Arbab <arbab@linux.vnet.ibm.com>,
 Mel Gorman <mgorman@suse.de>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180430094236.29056-1-david@redhat.com>
 <20180430094236.29056-2-david@redhat.com>
 <4d112f60-3c24-585e-152e-b42d68c899a2@oracle.com>
 <28068791-bee4-095e-7338-cda4d229c3de@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d9f6e3bc-5b36-4df6-e55a-d282eee9b050@redhat.com>
Date: Mon, 30 Apr 2018 17:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <28068791-bee4-095e-7338-cda4d229c3de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163720299287217?=
X-GMAIL-MSGID: =?utf-8?q?1599186827067646799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>>
>>>
>>> -static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>>> +extern void __meminit init_single_page(struct page *page, unsigned long pfn,
>>
>> I've seen it in other places, but what is the point of having "extern" function in .c file?
> 
> I've seen it all over the place, that's why I am using it :) (as I
> basically had the same question). Can somebody answer that?

BTW I was looking at the wrong file (header). This of course has to go!


-- 

Thanks,

David / dhildenb
