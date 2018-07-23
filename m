Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30386ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D239D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D239D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGWPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:10:25 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40287 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbeGWPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:10:25 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so467645qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jyv3pRG0wLPCfur1zW4AZCWIV2KY6pbU6E3QDzgVkXQ=;
        b=G84X3bufFPXoU1crXYWwjVqBJHN5ttLeen53khNbLxyE3dxa2OvBfKeJc7X45zD22h
         3mchCnHNAoYwRerZgEvi+LAOfbSr4MXM7KwLd/Qy5vG1Cw+8+B253C2M3KgXw9AjwVvM
         ydiSjYt8q93q/LO5nDomOAbFY9Nmb/wYddneCtDF9BxsrMut/7fFBbmgo13Ds/rRpISx
         jrQgW/7yJNQSA/SoNh+4eiuimKT3v8Xcv0vks6xG5TNdRC3E1lv3z9103nVofnNZ2Y6Q
         0CCVRTBPFoDxWx86Uf/gJpDccIl47Jo7Aw06klJfqoWdKXK96VgEuQQ+8WKiHnMb4ZBO
         T8tQ==
X-Gm-Message-State: AOUpUlGEmAYm6KpmqmnEm8eJdkeWDde/7Bcf2JML15v+5b+4/BNJTqQl
        88+4veOq2NTWPfMqLoXbC8OMkA==
X-Google-Smtp-Source: AAOMgpcRXHbbj+b+6InUUfqrEIRkW/Q7seASLMa2K12naQphr5iySdqwRAefsoVhXslGg5fzP+z0PQ==
X-Received: by 2002:a37:254a:: with SMTP id x71-v6mr11756696qkg.350.1532354939271;
        Mon, 23 Jul 2018 07:08:59 -0700 (PDT)
Received: from laptop.jcline.org (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id d202-v6sm5580151qkb.38.2018.07.23.07.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:08:58 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] bpf: Add Python 3 support to selftests scripts for bpf
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        jakub.kicinski@netronome.com
References: <20180718213610.19618-1-jcline@redhat.com>
 <1aa3dc98-2ab1-7386-d5d9-afd3dbb3fde9@iogearbox.net>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <dd971e43-3148-5a54-788e-d89835d3638a@redhat.com>
Date:   Mon, 23 Jul 2018 10:08:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1aa3dc98-2ab1-7386-d5d9-afd3dbb3fde9@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 07/20/2018 04:45 PM, Daniel Borkmann wrote:
> On 07/18/2018 11:36 PM, Jeremy Cline wrote:
>> Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
>> the print function, marking string literals as bytes, and using the
>> newer exception syntax. This should be functionally equivalent and
>> support Python 2.6 through Python 3.7.
>>
>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> 
> Thanks for the patch, Jeremy! Given we also have test_offload.py in BPF
> kselftests and it is written for python 3 only, it would probably make
> sense to adapt the tcp_{client,server}.py towards python 3 as well, so
> we wouldn't need to keep extra compat for 2 and have a consistent version
> dependency. Lawrence / Jeremy, any objections?

I certainly don't object to Python 3 only and I'm happy to drop the
Python 2 compatibility from this patch if that's okay.

> 
>>  tools/testing/selftests/bpf/tcp_client.py | 12 ++++++------
>>  tools/testing/selftests/bpf/tcp_server.py | 17 +++++++++--------
>>  2 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
>> index 481dccdf140c..9fe5f1b5c020 100755
>> --- a/tools/testing/selftests/bpf/tcp_client.py
>> +++ b/tools/testing/selftests/bpf/tcp_client.py
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/env python2
>> +#!/usr/bin/env python
>>  #
>>  # SPDX-License-Identifier: GPL-2.0
>>  #
>> @@ -9,11 +9,11 @@ import subprocess
>>  import select
>>  
>>  def read(sock, n):
>> -    buf = ''
>> +    buf = b''
>>      while len(buf) < n:
>>          rem = n - len(buf)
>>          try: s = sock.recv(rem)
>> -        except (socket.error), e: return ''
>> +        except (socket.error) as e: return b''
>>          buf += s
>>      return buf
>>  
>> @@ -22,7 +22,7 @@ def send(sock, s):
>>      count = 0
>>      while count < total:
>>          try: n = sock.send(s)
>> -        except (socket.error), e: n = 0
>> +        except (socket.error) as e: n = 0
>>          if n == 0:
>>              return count;
>>          count += n
>> @@ -39,10 +39,10 @@ try:
>>  except socket.error as e:
>>      sys.exit(1)
>>  
>> -buf = ''
>> +buf = b''
>>  n = 0
>>  while n < 1000:
>> -    buf += '+'
>> +    buf += b'+'
>>      n += 1
>>  
>>  sock.settimeout(1);
>> diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
>> index bc454d7d0be2..1d4a40a6584b 100755
>> --- a/tools/testing/selftests/bpf/tcp_server.py
>> +++ b/tools/testing/selftests/bpf/tcp_server.py
>> @@ -1,7 +1,8 @@
>> -#!/usr/bin/env python2
>> +#!/usr/bin/env python
>>  #
>>  # SPDX-License-Identifier: GPL-2.0
>>  #
>> +from __future__ import print_function
>>  
>>  import sys, os, os.path, getopt
>>  import socket, time
>> @@ -9,11 +10,11 @@ import subprocess
>>  import select
>>  
>>  def read(sock, n):
>> -    buf = ''
>> +    buf = b''
>>      while len(buf) < n:
>>          rem = n - len(buf)
>>          try: s = sock.recv(rem)
>> -        except (socket.error), e: return ''
>> +        except (socket.error) as e: return b''
>>          buf += s
>>      return buf
>>  
>> @@ -22,7 +23,7 @@ def send(sock, s):
>>      count = 0
>>      while count < total:
>>          try: n = sock.send(s)
>> -        except (socket.error), e: n = 0
>> +        except (socket.error) as e: n = 0
>>          if n == 0:
>>              return count;
>>          count += n
>> @@ -43,7 +44,7 @@ host = socket.gethostname()
>>  
>>  try: serverSocket.bind((host, 0))
>>  except socket.error as msg:
>> -    print 'bind fails: ', msg
>> +    print('bind fails: ' + str(msg))
>>  
>>  sn = serverSocket.getsockname()
>>  serverPort = sn[1]
>> @@ -51,10 +52,10 @@ serverPort = sn[1]
>>  cmdStr = ("./tcp_client.py %d &") % (serverPort)
>>  os.system(cmdStr)
>>  
>> -buf = ''
>> +buf = b''
>>  n = 0
>>  while n < 500:
>> -    buf += '.'
>> +    buf += b'.'
>>      n += 1
>>  
>>  serverSocket.listen(MAX_PORTS)
>> @@ -79,5 +80,5 @@ while True:
>>                  serverSocket.close()
>>                  sys.exit(0)
>>      else:
>> -        print 'Select timeout!'
>> +        print('Select timeout!')
>>          sys.exit(1)
>>
> 


