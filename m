Return-Path: <tursulin@ursulin.net>
ARC-Seal: i=1; a=rsa-sha256; t=1519035025; cv=none;
        d=google.com; s=arc-20160816;
        b=ZirMHpyyC9tfTeldpNDDiQ8oaGXVue+f+BZmSGlnlInL9sRPResRPArXbjVLMd83cj
         El+KrOFuePd4IgovDvkW2XRJIMWvYWkgElyR5VmgYqjwKQ7x+eu3R9RuzrQfx/0mQbYi
         lBCcSTo/fPDFNxtDGkTkxXaz4VUpwDy2AowNy1XcOlElnlNMcjARTTBYvUguwlDdG3MC
         gPuiDoZYTGJDe/1v84aksp2WXYwralr9ssYKpUn1L7FW/cyeMOswHpOHaMplc5B+zTpq
         cX+Silb9crZRopDk+PR7RlVY1vnMTd7xBLm4rRQf2dvdC2TKwhXR7Km9G9SpdMkGz4DZ
         Sk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=TEy/v89+jdPEfGMEL5KFPuaajehok8pTuBXjjyJom9w=;
        b=E6CvrJeHDU8A9lEki3DLFOc4dYPGCOnkOuyt9uO65vZTa9HmVp6DD2iTcLJYXaANW5
         QKsenAUIwYnJyYssj1nbd0ocarT9jhTl0zgPqlGDB6AmKuLDa9r7FBs0+NTcxMIXFfoP
         qxPU98yzX/f5KS/AFd4y6o5YN3OTa22+mHpTMtfNUFkVaTD/7AkVpZgwvtGVtW4ZYxEh
         X3xt4Lf0iitfyRBRUp7EojDCGrFPVo748ZfimnxdIaHjubUQIr+eoaRqVunfnVq0mLaq
         P+g2R2cVWKuW1u1uskxyhTe6alOY28nssyEFHWx+B1NviDg/9wmPHmNUmW12Rr7Rzk11
         e4fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ursulin-net.20150623.gappssmtp.com header.s=20150623 header.b=FYNxnJZ9;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of tursulin@ursulin.net) smtp.mailfrom=tursulin@ursulin.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ursulin-net.20150623.gappssmtp.com header.s=20150623 header.b=FYNxnJZ9;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of tursulin@ursulin.net) smtp.mailfrom=tursulin@ursulin.net
X-Google-Smtp-Source: AH8x224aTnUPfi7rQCr3cRr0e2ChqsCvpMikS+xlEkEDZCygaLr8Ab5Mgw/VpVIptYLA80Ncd52IMg==
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for
 LSB encodings
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jthumshirn@suse.de,
 axboe@kernel.dk, chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
 <201802180359.yuetSevh%fengguang.wu@intel.com>
 <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <8eacaf1d-1df8-edc6-36f6-d02748b50baa@ursulin.net>
Date: Mon, 19 Feb 2018 10:10:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592823671003297265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 19/02/18 04:12, Anshuman Khandual wrote:
> On 02/18/2018 12:58 AM, kbuild test robot wrote:
>> Hi Anshuman,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v4.16-rc1 next-20180216]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/lib-scatterlist-Add-SG_CHAIN-and-SG_END-macros-for-LSB-encodings/20180218-015554
>> config: x86_64-randconfig-s3-02180201 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from drivers/staging/rts5208/rtsx.h:180:0,
>>                      from drivers/staging/rts5208/rtsx.c:28:
>>>> drivers/staging/rts5208/rtsx_chip.h:343:0: warning: "SG_END" redefined
>>      #define SG_END   0x02
>>      
>>     In file included from include/linux/blkdev.h:28:0,
>>                      from drivers/staging/rts5208/rtsx.c:23:
>>     include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>>      #define SG_END  0x02UL
>>      
>>
>> vim +/SG_END +343 drivers/staging/rts5208/rtsx_chip.h
> 
> SG_END is already defined in a driver. Hence shall we change back
> 'SG_END' definition as 'SG_EMARK' or any other suggestions ?

Maybe SG_LAST? Going by existence of sg_is_chain and sg_is_last.

And also would probably be good to add something like:

#define SG_PAGE_BITS (SG_CHAIN | SG_LAST)
#define SG_PAGE_MASK (~SG_PAGE_BITS)

?

Regards,

Tvrtko
