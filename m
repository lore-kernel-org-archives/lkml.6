Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4/c/CrmYpcBMaTlKB/vzDGaPLRAq2vxldCz4ESJTSiDJSasGhuMliwiFp4f0U+xjdpHtXze
ARC-Seal: i=1; a=rsa-sha256; t=1523642127; cv=none;
        d=google.com; s=arc-20160816;
        b=RNviL5TEzXiDnjpX+nndBNtEaN/XhunWK7ISEJ+sNNlP2oM3zj6snruz7LZ6Pk0EGJ
         4i5ld+YkLXybQXQXeJp3YIGlQPuu3zNDsx08fgoq4pu+CJD7u8Ww/ii59SzUEcUUcaU3
         B1XLw5PANkNQaiKaskOWvpubI/W6KyTtdxgJG6sMS18/7mnkOqtDYSzizOcvZKiqUCr3
         Wko1ioZ4tHME/KluwSehTX5l5hp7/eh0YfO8/x1po5wONiSfyqHfCReeVAMb5yVXkxDJ
         yEkP/ZIzqBg+U0RMACl/PVAjePotRQvsbZ3VTe/Et//4Wus39Ve8WOYdKEpA6trzpXB/
         EAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=PMeJzldFIqKot3wDaDS2O6K2hvcaf9/V7lJ2AmMz/d8=;
        b=qqYGWoYlyOzCzsXSvX3r5UHmQ7gI6hOPQ2djgwTYlXd3qUPTg1kMKthB/a/oeLUycb
         UtR+y6GggcmjM+HXvz3qIEQuG9AZgaEtDbScyaq5E8F3ib0bzMyDtg1jE73AaLW6c5NM
         7UfyQJzlQW63hXUtzA1pi7Hiw/+u4wQAuoRJa1yjaiZhRiw6Qfs/MCxAEB3qFn4i02IM
         BmDjyCPWowO5tjp17tzROzS4HEQe1bk0AmNaDYXasKFrjBZ91pJJsBAJo8ebDSJ+9ldd
         WA0fMSfNT6Fkpoqqax3yikZ0nPeGszivqs6viDurLHVuO0o+2cVpt5PFQvQq7xT3Ox9u
         1zQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ZtdQ6sDt;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ZtdQ6sDt;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 2/6] statfs: use << to align with fs header
To: Andreas Dilger <adilger@dilger.ca>,
 Christian Brauner <christian.brauner@ubuntu.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org, serge@hallyn.com
References: <20180413161126.31313-1-christian.brauner@ubuntu.com>
 <20180413161126.31313-3-christian.brauner@ubuntu.com>
 <833FF27F-CFAD-4011-A21C-86B3947BB7D5@dilger.ca>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <de6ba300-fbef-07ae-651e-87e25ffd701d@infradead.org>
Date: Fri, 13 Apr 2018 10:55:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <833FF27F-CFAD-4011-A21C-86B3947BB7D5@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597648046265390168?=
X-GMAIL-MSGID: =?utf-8?q?1597654568267102213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 10:35 AM, Andreas Dilger wrote:
> On Apr 13, 2018, at 10:11 AM, Christian Brauner <christian.brauner@ubuntu.com> wrote:
>>
>> Consistenly use << to define ST_* constants. This also aligns them with
>> their MS_* counterparts in fs.h
> 
> IMHO, using (1 << 10) makes the code harder to debug.  If you see a field
> in a structure like 0x8354, it is non-trivial to map this to the ST_*
> flags if they are declared in the form (1 << 10) or BIT(10).  If they are
> declared in the form 0x100 (as they are now) then it is trivial that the
> ST_APPEND flag is set in 0x8354, and easy to understand the other flags.
> 
> So, my preference would be to NOT land this or the previous patch.

That makes sense to me.

-- 
~Randy
