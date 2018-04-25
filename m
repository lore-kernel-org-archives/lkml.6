Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZooDJZLAdF36rDmFfHet31mbUwMpJV4AyMLRZT/AvG9VT1l8tYq3NPp2PK4rFG5GZ1JEFzz
ARC-Seal: i=1; a=rsa-sha256; t=1524670263; cv=none;
        d=google.com; s=arc-20160816;
        b=mOb+77Nln4fcflxCMpbF690WlK4bARNttagAT2F97nndfJp790ctCMAZlk2SxkvW4K
         RBOWefGDaNLTdGjA/EPRz9HYSBq9q92IHaZBB/SUcyiGpkWY6QVdHACYVvQ8A6jf1y2T
         ZKcxyOF4qM0drWaAPIlSib5OSsbg8Nwh+rib1lay5UMwF2PN3rMA8mOXIXz9hDI47iln
         xg658uUQ3btjE6VzxAIkXbq19nLgRgi56PXNntfCjZ4dDXb6lQMpeIJg59bJmCBholH0
         KoCKIfhvidmXPsrapWI9JhwfT4RhA5wFv9dfdum7Sd1fcFOUsNGFPxRBiw87Qc7QdWpY
         FSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=8JWtmVogzzSXpSzc3JwIFg3gO0OCbCx9NNSX/WqCGZI=;
        b=N/hiq4zaGZo/Q+tuMufVeFAwEl/BVv6c1VkhfxKc2QKVJauOb0lQLeQM85iMBHVbU3
         PgYpCCBKkPjhj2a6S1cTCZvatNTFLudIFMLGhYck0lf89ngs7Wyz+tgN2TbQRROkqz3y
         TzM7eVHzGXNGOXXT/3mGpjSaOcYwSHXTeDOl60DL1pchPCo3KtRX8VAWvb+rCJK86lpX
         MYHYVu/E+gWwiy8TY3JYo2WrVAtftktgk9IzbaNvOkHTdv2eArY/NCQHoLMtR3Ubtsup
         wXGzpEQz19VXpb9TGVtF0KiknfFrbD2GgzVKar1hj4L4wVH7N0PXGDWHRRlnmzvthP8e
         lCnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.68.200.34 is neither permitted nor denied by best guess record for domain of shuah@kernel.org) smtp.mailfrom=shuah@kernel.org
Subject: Re: [PATCH] selftests:firmware: fixes a call to a wrong function name
To: Greg KH <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>
Cc: Jeffrin Jose T <ahiliation@yahoo.co.in>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180423141022.5019-1-ahiliation@yahoo.co.in>
 <CAGXu5jL0FKq=_fESYT78_LPOVYQ4MsPHQ6u_RgFBJa4fzNN3rQ@mail.gmail.com>
 <20180425152657.GA5139@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <ad2a60e7-d8a1-fe6b-e3c4-bdb71060245e@kernel.org>
Date: Wed, 25 Apr 2018 09:30:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425152657.GA5139@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598546450187595839?=
X-GMAIL-MSGID: =?utf-8?q?1598732645846468028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 09:26 AM, Greg KH wrote:
> On Mon, Apr 23, 2018 at 09:39:02AM -0700, Kees Cook wrote:
>> On Mon, Apr 23, 2018 at 7:10 AM, Jeffrin Jose T <ahiliation@yahoo.co.in> wrote:
>>>  This is a patch to the tools/testing/selftests/firmware/fw_run_tests.sh
>>>  file which fixes a bug which calls to a wrong function name,which in turn
>>>  blocks the execution of certain tests.
>>>
>>> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
>>>
>>> ---
>>>  tools/testing/selftests/firmware/fw_run_tests.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
>>> index 06d638e9dc62..cffdd4eb0a57 100755
>>> --- a/tools/testing/selftests/firmware/fw_run_tests.sh
>>> +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
>>> @@ -66,5 +66,5 @@ if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
>>>         run_test_config_0003
>>>  else
>>>         echo "Running basic kernel configuration, working with your config"
>>> -       run_test
>>> +       run_tests
>>>  fi
>>
>> I find it confusing that run_tests() uses $1 and $2 but later ignores
>> them unless -f $FW_FORCE_SYSFS_FALLBACK, which is checked at both the
>> top level and in proc_set_*_fallback()... I'd expected the test to
>> happen only in run_tests() and have it removed from from
>> proc_set_*_fallback().
>>
>> Regardless, the above patch is correct to run the tests. :)
> 
> Thanks, I'll go queue this up.
> 
> greg k-h
> 

Thanks. This probably has dependency on firmware tree.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

-- Shuah
