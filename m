Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeFDHpz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:45:55 -0400
Received: from mout2.freenet.de ([195.4.92.92]:40802 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbeFDHpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:45:53 -0400
Subject: Re: Spectre mitigation doesn't seem to work at all?!
From: Andreas Hartmann <andihartmann@01019freenet.de>
To: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
 xsDiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0Zs1HQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz7CYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRs7A
 TQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 wkYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrY
Message-ID: <e6c80163-0d73-1bf8-9c3f-1184a73040f6@01019freenet.de>
Date: Mon, 4 Jun 2018 09:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-score: -3.1
X-Spamreport: Action: no action
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: SUBJECT_HAS_QUESTION(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ASN(0.00)
 Symbol: MID_RHS_MATCH_FROM(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: SUBJECT_ENDS_EXCLAIM(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: NEURAL_HAM(-3.00)
 Message-ID: e6c80163-0d73-1bf8-9c3f-1184a73040f6@01019freenet.de
X-FN-Spambar: 
X-Originated-At: 2003:de:53d7:1800:5054:ff:fe15:ac42!58016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Sorry for a ping - but I think the behavior shown below should really be
investigated!


Thanks,
Andreas




On 06/01/2018 at 02:19 PM Andreas Hartmann wrote:
> Hello!
> 
> I tested the spectre mitigation of different machines and kernels with
> https://github.com/crozone/SpectrePoC
> 
> You can see the results below.
> 
> 
> My question: Did I miss something?
> My expectation was, that on base of the output of
> /sys/devices/system/cpu/vulnerabilities/spectre_v* as shown below the
> problem should be gone away.
> But the results seem to tell me something other ... .
> 
> 
> Thanks
> Andreas
> 
> 
> 
> 
> ----------------------------------------------------------------------------------------------------------------------
> 
> CPU:    AMD Ryzen 7 1700X Eight-Core Processor
> Bios:   BIOS 4011 04/19/2018 - ibpb is listed in /proc/cpuinfo
> Kernel: 4.14.44-1.1-default
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Mitigation: Full AMD retpoline, IBPB
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
> Mitigation: __user pointer sanitization
> 
>  ./spectre.out
> Using a cache hit threshold of 80.
> Build: RDTSCP_SUPPORTED MFENCE_SUPPORTED CLFLUSH_SUPPORTED
> INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> Reading 40 bytes:
> Reading at malicious_x = 0xffffffffffdfec18... Success: 0x54=’T’ score=2
> Reading at malicious_x = 0xffffffffffdfec19... Success: 0x68=’h’ score=2
> Reading at malicious_x = 0xffffffffffdfec1a... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec1b... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec1c... Success: 0x4D=’M’ score=2
> Reading at malicious_x = 0xffffffffffdfec1d... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec1e... Success: 0x67=’g’ score=2
> Reading at malicious_x = 0xffffffffffdfec1f... Success: 0x69=’i’ score=2
> Reading at malicious_x = 0xffffffffffdfec20... Success: 0x63=’c’ score=2
> Reading at malicious_x = 0xffffffffffdfec21... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec22... Success: 0x57=’W’ score=2
> Reading at malicious_x = 0xffffffffffdfec23... Success: 0x6F=’o’ score=2
> Reading at malicious_x = 0xffffffffffdfec24... Success: 0x72=’r’ score=2
> Reading at malicious_x = 0xffffffffffdfec25... Success: 0x64=’d’ score=2
> Reading at malicious_x = 0xffffffffffdfec26... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec27... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec28... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec29... Success: 0x72=’r’ score=2
> Reading at malicious_x = 0xffffffffffdfec2a... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec2b... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec2c... Success: 0x53=’S’ score=2
> Reading at malicious_x = 0xffffffffffdfec2d... Success: 0x71=’q’ score=2
> Reading at malicious_x = 0xffffffffffdfec2e... Success: 0x75=’u’ score=2
> Reading at malicious_x = 0xffffffffffdfec2f... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec30... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec31... Success: 0x6D=’m’ score=2
> Reading at malicious_x = 0xffffffffffdfec32... Success: 0x69=’i’ score=2
> Reading at malicious_x = 0xffffffffffdfec33... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec34... Success: 0x68=’h’ score=2
> Reading at malicious_x = 0xffffffffffdfec35... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec36... Success: 0x4F=’O’ score=2
> Reading at malicious_x = 0xffffffffffdfec37... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec38... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec39... Success: 0x69=’i’ score=2
> Reading at malicious_x = 0xffffffffffdfec3a... Success: 0x66=’f’ score=2
> Reading at malicious_x = 0xffffffffffdfec3b... Success: 0x72=’r’ score=2
> Reading at malicious_x = 0xffffffffffdfec3c... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec3d... Success: 0x67=’g’ score=2
> Reading at malicious_x = 0xffffffffffdfec3e... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec3f... Success: 0x2E=’.’ score=2
> 
> 
> ----------------------------------------------------------------------------------------------------------------------
> 
> CPU:    AMD G-T40E Processor
> Kernel: 4.14.44-1.el6.x86_64
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
> Mitigation: __user pointer sanitization
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Mitigation: Full AMD retpoline
> 
> ./spectre.out 130
> Using a cache hit threshold of 130.
> Build: RDTSCP_SUPPORTED MFENCE_SUPPORTED CLFLUSH_SUPPORTED
> INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> Reading 40 bytes:
> Reading at malicious_x = 0xffffffffffdfebf0... Unclear: 0x54=’T’
> score=999 (second best: 0x00=’?’ score=992)
> Reading at malicious_x = 0xffffffffffdfebf1... Unclear: 0x68=’h’
> score=996 (second best: 0x00=’?’ score=988)
> Reading at malicious_x = 0xffffffffffdfebf2... Unclear: 0x65=’e’
> score=999 (second best: 0x00=’?’ score=985)
> Reading at malicious_x = 0xffffffffffdfebf3... Unclear: 0x20=’ ’
> score=997 (second best: 0x00=’?’ score=989)
> Reading at malicious_x = 0xffffffffffdfebf4... Unclear: 0x4D=’M’
> score=999 (second best: 0x00=’?’ score=993)
> Reading at malicious_x = 0xffffffffffdfebf5... Unclear: 0x61=’a’
> score=998 (second best: 0x00=’?’ score=991)
> Reading at malicious_x = 0xffffffffffdfebf6... Unclear: 0x67=’g’
> score=996 (second best: 0x00=’?’ score=988)
> Reading at malicious_x = 0xffffffffffdfebf7... Unclear: 0x69=’i’
> score=998 (second best: 0x00=’?’ score=987)
> Reading at malicious_x = 0xffffffffffdfebf8... Unclear: 0x63=’c’
> score=999 (second best: 0x00=’?’ score=989)
> Reading at malicious_x = 0xffffffffffdfebf9... Unclear: 0x20=’ ’
> score=999 (second best: 0x00=’?’ score=989)
> Reading at malicious_x = 0xffffffffffdfebfa... Unclear: 0x57=’W’
> score=998 (second best: 0x5B=’[’ score=985)
> Reading at malicious_x = 0xffffffffffdfebfb... Unclear: 0x6F=’o’
> score=998 (second best: 0x00=’?’ score=988)
> Reading at malicious_x = 0xffffffffffdfebfc... Unclear: 0x00=’?’
> score=985 (second best: 0xF7=’?’ score=942)
> Reading at malicious_x = 0xffffffffffdfebfd... Unclear: 0x64=’d’
> score=999 (second best: 0x00=’?’ score=990)
> Reading at malicious_x = 0xffffffffffdfebfe... Unclear: 0x73=’s’
> score=998 (second best: 0x00=’?’ score=984)
> Reading at malicious_x = 0xffffffffffdfebff... Unclear: 0x20=’ ’
> score=998 (second best: 0x00=’?’ score=985)
> Reading at malicious_x = 0xffffffffffdfec00... Unclear: 0x61=’a’
> score=999 (second best: 0x00=’?’ score=984)
> Reading at malicious_x = 0xffffffffffdfec01... Unclear: 0x72=’r’
> score=999 (second best: 0x00=’?’ score=986)
> Reading at malicious_x = 0xffffffffffdfec02... Unclear: 0x65=’e’
> score=998 (second best: 0x00=’?’ score=980)
> Reading at malicious_x = 0xffffffffffdfec03... Unclear: 0x20=’ ’
> score=998 (second best: 0x00=’?’ score=992)
> Reading at malicious_x = 0xffffffffffdfec04... Unclear: 0x53=’S’
> score=997 (second best: 0x50=’P’ score=990)
> Reading at malicious_x = 0xffffffffffdfec05... Unclear: 0x71=’q’
> score=998 (second best: 0x00=’?’ score=984)
> Reading at malicious_x = 0xffffffffffdfec06... Unclear: 0x75=’u’
> score=999 (second best: 0x72=’r’ score=976)
> Reading at malicious_x = 0xffffffffffdfec07... Unclear: 0x65=’e’
> score=999 (second best: 0x00=’?’ score=988)
> Reading at malicious_x = 0xffffffffffdfec08... Unclear: 0x61=’a’
> score=999 (second best: 0x00=’?’ score=986)
> Reading at malicious_x = 0xffffffffffdfec09... Unclear: 0x6D=’m’
> score=999 (second best: 0x00=’?’ score=987)
> Reading at malicious_x = 0xffffffffffdfec0a... Unclear: 0x69=’i’
> score=998 (second best: 0x00=’?’ score=987)
> Reading at malicious_x = 0xffffffffffdfec0b... Unclear: 0x73=’s’
> score=984 (second best: 0x00=’?’ score=974)
> Reading at malicious_x = 0xffffffffffdfec0c... Unclear: 0x00=’?’
> score=991 (second best: 0xB4=’?’ score=933)
> Reading at malicious_x = 0xffffffffffdfec0d... Unclear: 0x20=’ ’
> score=999 (second best: 0x00=’?’ score=986)
> Reading at malicious_x = 0xffffffffffdfec0e... Unclear: 0x4F=’O’
> score=998 (second best: 0x50=’P’ score=991)
> Reading at malicious_x = 0xffffffffffdfec0f... Unclear: 0x73=’s’
> score=999 (second best: 0x00=’?’ score=987)
> Reading at malicious_x = 0xffffffffffdfec10... Unclear: 0x73=’s’
> score=998 (second best: 0x00=’?’ score=971)
> Reading at malicious_x = 0xffffffffffdfec11... Unclear: 0x69=’i’
> score=999 (second best: 0x00=’?’ score=980)
> Reading at malicious_x = 0xffffffffffdfec12... Unclear: 0x66=’f’
> score=998 (second best: 0x00=’?’ score=978)
> Reading at malicious_x = 0xffffffffffdfec13... Unclear: 0x72=’r’
> score=995 (second best: 0x00=’?’ score=981)
> Reading at malicious_x = 0xffffffffffdfec14... Unclear: 0x61=’a’
> score=996 (second best: 0x00=’?’ score=971)
> Reading at malicious_x = 0xffffffffffdfec15... Unclear: 0x67=’g’
> score=999 (second best: 0x00=’?’ score=975)
> Reading at malicious_x = 0xffffffffffdfec16... Unclear: 0x65=’e’
> score=999 (second best: 0x00=’?’ score=984)
> Reading at malicious_x = 0xffffffffffdfec17... Unclear: 0x2E=’.’
> score=999 (second best: 0x00=’?’ score=987)
> 
> 
> 
> ---------------------------------------------------------------------------------------------------------------------
> 
> CPU:    Intel(R) Core(TM) i5 CPU       M 460  @ 2.53GHz
> Kernel: 4.16.5-13.1-default
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Mitigation: Full generic retpoline
> cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
> Mitigation: __user pointer sanitization
> 
>  ./spectre.out
> Using a cache hit threshold of 80.
> Build: RDTSCP_SUPPORTED MFENCE_SUPPORTED CLFLUSH_SUPPORTED
> INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> Reading 40 bytes:
> Reading at malicious_x = 0xffffffffffdfebe8... Success: 0x54=’T’ score=2
> Reading at malicious_x = 0xffffffffffdfebe9... Success: 0x68=’h’ score=2
> Reading at malicious_x = 0xffffffffffdfebea... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfebeb... Success: 0x20=’ ’ score=7
> (second best: 0x21=’!’ score=1)
> Reading at malicious_x = 0xffffffffffdfebec... Success: 0x4D=’M’ score=2
> Reading at malicious_x = 0xffffffffffdfebed... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfebee... Success: 0x67=’g’ score=2
> Reading at malicious_x = 0xffffffffffdfebef... Success: 0x69=’i’ score=7
> (second best: 0xB2=’?’ score=1)
> Reading at malicious_x = 0xffffffffffdfebf0... Success: 0x63=’c’ score=2
> Reading at malicious_x = 0xffffffffffdfebf1... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfebf2... Success: 0x57=’W’ score=2
> Reading at malicious_x = 0xffffffffffdfebf3... Success: 0x6F=’o’ score=2
> Reading at malicious_x = 0xffffffffffdfebf4... Success: 0x72=’r’ score=2
> Reading at malicious_x = 0xffffffffffdfebf5... Success: 0x64=’d’ score=2
> Reading at malicious_x = 0xffffffffffdfebf6... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfebf7... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfebf8... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfebf9... Success: 0x72=’r’ score=7
> (second best: 0x22=’"’ score=1)
> Reading at malicious_x = 0xffffffffffdfebfa... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfebfb... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfebfc... Success: 0x53=’S’ score=2
> Reading at malicious_x = 0xffffffffffdfebfd... Success: 0x71=’q’ score=2
> Reading at malicious_x = 0xffffffffffdfebfe... Success: 0x75=’u’ score=2
> Reading at malicious_x = 0xffffffffffdfebff... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec00... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec01... Success: 0x6D=’m’ score=2
> Reading at malicious_x = 0xffffffffffdfec02... Success: 0x69=’i’ score=2
> Reading at malicious_x = 0xffffffffffdfec03... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec04... Success: 0x68=’h’ score=2
> Reading at malicious_x = 0xffffffffffdfec05... Success: 0x20=’ ’ score=2
> Reading at malicious_x = 0xffffffffffdfec06... Success: 0x4F=’O’ score=2
> Reading at malicious_x = 0xffffffffffdfec07... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec08... Success: 0x73=’s’ score=2
> Reading at malicious_x = 0xffffffffffdfec09... Success: 0x69=’i’ score=2
> Reading at malicious_x = 0xffffffffffdfec0a... Success: 0x66=’f’ score=2
> Reading at malicious_x = 0xffffffffffdfec0b... Success: 0x72=’r’ score=2
> Reading at malicious_x = 0xffffffffffdfec0c... Success: 0x61=’a’ score=2
> Reading at malicious_x = 0xffffffffffdfec0d... Success: 0x67=’g’ score=7
> (second best: 0x42=’B’ score=1)
> Reading at malicious_x = 0xffffffffffdfec0e... Success: 0x65=’e’ score=2
> Reading at malicious_x = 0xffffffffffdfec0f... Success: 0x2E=’.’ score=2
> 
> 
