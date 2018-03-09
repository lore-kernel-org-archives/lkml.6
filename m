Return-Path: <prvs=66068847af=ast@fb.com>
X-Google-Smtp-Source: AG47ELu53h3k6XEC42xWfbXQt5qd6lINVotpGLEpgBQ9otjaJ63ORpBhUGhlgk62CKQBqQ2kRHBs
ARC-Seal: i=1; a=rsa-sha256; t=1520616789; cv=none;
        d=google.com; s=arc-20160816;
        b=k6z/mH9BXye08inC0xiLr3e/kbuBCVm3jgJ7Yv3kQlUb9LNcs0wRWvjrkhPTxipmMP
         2erWkTlcwtz4QBdswM1kSYz9pAPP0nSSMPjmHwaIco2fx7innDdabwM2tKwrHiqEkfsj
         NVv+STukEF/QM5R84Xn4j269wz/qQThV4RMvisdMdGQ3kLshTSNDxIV5lLvt2iMfaiKJ
         Mrxh17FXcToFgG9rg3q1KR7R+kY5EQWcO8RmJXyTvxbP7GLWwVBHQEGxmT9/Hnhn+juZ
         uRte152scwCzJCLT18VhshCIutsNFc58DwW6INcUAjoFdMhvsHL53HrA8KQPkx5gJMNf
         W9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=DfPZXqne5ScK1Ebar5CH2KbSOtFKv1A/0KoDbb87kcc=;
        b=0WDbixf0UY/ZjbPL1dqrfig3zFgHzF2eLRp+h9hXkkJtDuJnRkOlwLoaXQtyHCmM4O
         Fq+goVWJlxUc4UDxTKGYUD0DrDSBGtLi4cTKskoxbln4A3Z/QQzfOPTntk33tSPIlroj
         FziVOrJEh6Qt5NlFPHHMsheZrqRt3eQOJ9gvGyurCjoOOibXxBpG0NJUtD09fTLCVtl5
         rpIBXza1tUr2qGw1XVEzN4exMfAAsCFxlEl5J7FqMihPGBbvRJgYjbo/90lHjMoN/ZGH
         Esb5n78GfWSCM9cUDNrE9ZoeaZlwhbKWClaA3P8e0c79ahO+T9hKtOG+NN1sEi52jmYq
         0UXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=hZrqdOwS;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=G/NdbpNg;
       spf=pass (google.com: domain of prvs=66068847af=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=66068847af=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=hZrqdOwS;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=G/NdbpNg;
       spf=pass (google.com: domain of prvs=66068847af=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=66068847af=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
 <6d2e31fa-d87b-fea6-c919-b7d066bb0385@fb.com>
 <CALCETrX+oGQthnk5AR0MUJwLLwguWG_yq_r9QQPhUYjvz9jyPw@mail.gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook
	<keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni
	<tixxdz@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller"
	<davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux API
	<linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <c9388b10-19ac-0bd5-4986-9c306d23046e@fb.com>
Date: Fri, 9 Mar 2018 09:32:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX+oGQthnk5AR0MUJwLLwguWG_yq_r9QQPhUYjvz9jyPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::7:649b]
X-ClientProxiedBy: MWHPR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:300:13d::25) To DM6PR15MB2507.namprd15.prod.outlook.com
 (2603:10b6:5:8e::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2f3571-08d7-4355-073f-08d585e3c290
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;3:+39urAHqEXq+Dj+mq7cj3JFGiiKgvY73Qu6HRnrfwOR9KLFJ83IZ4WWOa1cwY9DLUCqbSxTe8oHWjg1pu7w0W3LCqAM7XGCWSkmONQkbbRUeyGsmQQnZI0vGxABmvR9Ci+RBm2KonORaghKtTOJTAuFQeepFEiVfdIxbTfykq/E27Z7rIcOQkkXNRbytcArhjkaLHouoRLOs0Ib8ZzNgyZ94Z2/aSfoxXICfRbKSwFUx5EIi1erViAjX44yHMaeS;25:btl2dOxmkAR4zvOgYXBTSe02LxccCrzk8R7rBowuIp2WC+MWnaYREhf+MWhv+8SG0GF0W+yhpRIRWKth/E4KNKElWbuDVuMV9r09IqwyABFYRBe5ut7UvwTLmqodnDfmCvZYenHTjL/aMeP4NUPST9xR1uzBcl/qX6qD00RjHbhC5Dvsvsvn0mlwfwXb5lFkZNA00XSyR8VQqWdghuRKUHIS3u3iYZJEXOGfJurHvbxq7BRY48jS9pDWIfZXGgws3TmY6Kc/3hj9G+DOdFLp40h6QPX8wd6UrekDpL2iugqoi9gF2tEPd/zBZp3DzgNfjLwQfz9vBZiSbeeVY52ohQ==;31:fijzFQgXKT6NVLx46OqzOfB2jJ0+gZVySwyIimpPUsKTImlpJG4S09RgfoZzr4yvc8KoFykoIpseehwXShM+MoF7bQgxKHjLLiPYfRDY7LwHIe/Yf2ad9sY+L5yzV3yCNcgQRlYfCnfpr1Z95nSw1PTt94BFuVgS1Lk0nn595PW5V20ezKzXAiXII2hsNkhPEahTUtks+jV39r1DY/NSXONfU+h6XA8/6sCpIeCQks0=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:G7Bn2Wy0cj66BdE1UIVJt9S20uoopnLTyLnt0TmfUcrSb3Ey4GEfivtL7w38R7NzrisrILgDviqPKc+OzjSeKUhfm/h9B304qleBIrQaSK9SOWLP1P5pG8k8FuLqrd6wDu5KeQjmJ/z9cSH2SLyJO1t544Qj7/Q9EUUjidKsEWHfEaEm33hvGeUkohaI+YcmK6LU3xkO3BLNsN0MxNV9jRRw/Pq4R46uu5OnJyDLFXcgaL32CN08gbHQWJtDepOleb08c6t3oJGP0xzZQ0w4VfFKNof6p6VVxksIsd43B4XJS2zqmGg3fMC/tdKUf9Q+CoUx0eGBD9dodM66PdBzohooUqtV8aZZCzoL1ULrcR5Sp0F8OAxjnI4GKNLVdzM2dGTkivRQAOAnUxtM316E1LycNZxiAxIaD7dHFP/tnM2fdMNtdL06CPXoiKO5K02OTE+BLi338cX0RHmdKcTIXNleTOIktG1Y/i+JdwibPpzsrb9FcoLvUupd256+xYnA;4:1+j0JI4FKvN8hxSImcTxumDY3kBjcMxUY86yVKktT/xMlyn5x6se6pnnKNXONrdUdsC+LFuZv4YhUxOifbcrDTrnCDVA60Z+d8UZObsFXzlpSFILuS8foRsYswaacXYzCEKYAAdi8Aocn9Nb1JqJsi0/4frNc3XvYTSprdoe8mQqa4Cl9ixFlCKeQ1Oh5ZYWJYNMHokVKSqviZn1yUNh95t5wmEsgXOXlnDXv/vjncBh7YGQ2yfNNJ7va4eo7xna94NY6iTROzlCDJcX8BMJF8t+p0cNXem0FB2U66UTxdVoxh5loa5omXlIALf/FtV8J6Lbbs48Vz91I4MW/J6L8lrQUF6USr7sQqogmhJ1yPk=
X-Microsoft-Antispam-PRVS: <DM6PR15MB25079F858C9D5355EB84FAD9D7DE0@DM6PR15MB2507.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM6PR15MB2507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2507;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(189003)(199004)(25786009)(65806001)(6486002)(52396003)(50466002)(36756003)(64126003)(86362001)(305945005)(105586002)(478600001)(6246003)(59450400001)(39060400002)(76176011)(52116002)(4326008)(46003)(316002)(386003)(53546011)(65956001)(2906002)(52146003)(2486003)(23676004)(47776003)(53936002)(2870700001)(229853002)(6666003)(8936002)(8676002)(97736004)(81156014)(81166006)(58126008)(6116002)(7416002)(67846002)(1706002)(31686004)(68736007)(186003)(6916009)(5660300001)(106356001)(16526019)(93886005)(2950100002)(65826007)(31696002)(54906003)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2507;H:[IPv6:2620:10d:c082:1055:e43f:a97f:ff02:4c5a];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjE1TUIyNTA3OzIzOlV0TGlISDc2ck90eUpyOS9NMm1kMFc5OW5r?=
 =?utf-8?B?eW4zMm5CQ0d2SlVqalJSZGJwendxS3dVTTB1Vkp3enJRQTBvcUppeGVMbU1s?=
 =?utf-8?B?L0hqQVdrOG83SXVMT2NLN2d6YkVWa1Y3ZVRkZUJNSHAwWlVJQlRQdHRMVW55?=
 =?utf-8?B?RVROOXVJRlp3UHFBSGVFeWtJZVUzcDhaU2RBUmRRYXljTXY2aEQxbFpVaFFE?=
 =?utf-8?B?bXNaa0YvMHdCRGFjc0x3emJEMGJSMVhTMk5zejFrb3dWOU9EVm1DbE5lM2ZV?=
 =?utf-8?B?a1JGT1RweG1NODdDN3FyNFdSSy8rUUZJUHp2a2RxOVdRZ1d5SWEydmFoOCts?=
 =?utf-8?B?L0dOdjZoQ2dYdWR3b3pTVDd3RXhoUXBFZG5KYnZUL1JZL3RKdzBHY1BTYTBn?=
 =?utf-8?B?bXJCRzdqMjRPSGp4cXNvWUQ4aDQ2WXYzZnVSenJTdmhVSS91R3VVTU1zR1RZ?=
 =?utf-8?B?c2JIQmZsNEpuTW01MFJhL0hMV1RWbHpST05QWWNqZk1QSmxSQ3ZZcDVxSktZ?=
 =?utf-8?B?RXZHQVdURjhldFpHRmNFbjFxWHJpVGZXM2kySWl3VGJYdVpaVGZtZDV3cGhl?=
 =?utf-8?B?RjBTUWRuOUd5dllXU21SSDJZaDlwbnE0bC82WXM5NjFiTjhvN29FQUtaWnBX?=
 =?utf-8?B?eTk5VmkxOXp3VWl5ZDI1c3VkbGNOSmhBczRXVkJwblFVNVQ1WmpnN2xJU3VI?=
 =?utf-8?B?bGk4Mm14ZnoyYlBBVDAwalE4Z2Z0cVJRSDd1c21pVkRXYWt2bmtCVWFIWHBX?=
 =?utf-8?B?Sm5RdnBwRFlSdFd6MVpZcnNYWkFGQjZXOGFnTGw1cXZ5cHFQeTlZeWhieGN5?=
 =?utf-8?B?alpBQjN5K0FGb3V4czBrRDhtTitFVlowelFxSDZDcElIVjBuaVpld0I3VGM3?=
 =?utf-8?B?ZXpRSTQ2Y2xBbGlJYUxKWXdnTVNxdVJnM0pMcVJKWG8zaWY5Q0xkZW4rSXdz?=
 =?utf-8?B?N05ncnJiZnF4UDlOMjFDSHlyTCt2ejdrUnE2NXg2YklqK0ZsR1E2Q0dqTncy?=
 =?utf-8?B?RlduMk1FRFJnVUZLMnkzN3JBWDJJNko3c3dYT05yL05Tb2tiZ2RIalBidisw?=
 =?utf-8?B?S052MzljdUNNNkU5ZndDR3FCYWFnU3VtQW5iUVdNZGMrL3I3SEFpRzZGKzZL?=
 =?utf-8?B?OXpsR1JIclE4ZWh4Rm1DaEM0UnFLZHdVbmw3RjExaFJ5elVKQk1WRTdNSjZ6?=
 =?utf-8?B?dkZHQWN1MWpkU0ZUZytVaGRVTzdYb2ROMy9URnFQWFE0MlUxa3VMVGlGVDV3?=
 =?utf-8?B?RHMycDBuUGdDWDJuL1M3VHE1U21NZUNMeDNneEt0QlJCbEwrclRaaDJuZ1Rl?=
 =?utf-8?B?aGFFVUdIWk9EcXBrcGRFK0hPQ1UxZis4VTh3THhCY2tCd2FvNDErTFhVOHlD?=
 =?utf-8?B?TkMrQkVaWDBaY0F0bU5LR0dwanlUcW1MUmhHbFZFSVV5U0RCUkEvMHBVRzhE?=
 =?utf-8?B?RXl6a1R3bzJ4QWZLZmVCSVo4VTZOTkpmbnYyWk1RYVRZNUhOaGRFUEF4WUhM?=
 =?utf-8?B?bGlTc0gxRkU1MWRYcGVsNUVkNGs2dDIwdmtndU0vQVlyRHBKZkJIdkM0U2sz?=
 =?utf-8?B?dmM4d2IwTmtIcUo1TWRFczNDajBrc0FESnpVbUhUd3BFT2pReHU1aGdwempy?=
 =?utf-8?B?bGZ2Q09TQVdoV000dW5xYWtMRW9COTF4V0x5Sjc1VVBHWUhjczlUSERodXBH?=
 =?utf-8?B?YzRoc2s0a2xXcjJ6TTRjK0NPR1NWa1JqbXZsaGM3dlB6MDBldG9Yejk1MGR4?=
 =?utf-8?B?UzJNUGMzdnE0bGdZMG41OG10K1N6T2pSS3Jhd21mZVdQUzBtcVVtSkR4TUF0?=
 =?utf-8?B?RXFIMGdVNkRHNjczWWxleEtTL3NBMTBxL01Rc2plb2NlMWo0UmxJRzR4Q0t0?=
 =?utf-8?B?REF0M2I3Vm1EdjI2bkM5MHpWdy80Q3FBVC9TQmZYNGtjcm9pTWtIRnpmODZD?=
 =?utf-8?Q?Yi4a4NUPyV7XTArI3ZUPzECuj7sMno=3D?=
X-Microsoft-Antispam-Message-Info: ZcRI7qWlFZ3z3/bISampZeBTZtWxHNDc1dCtuxsCRqLPWivmnMBGz1XqMdCf3RI0FvvI6yeccMArGiMkK62sHYBC/gdQCNsutbgntQSKepDe8AtSGgjZTmW/oavTxGa+HxB+bGRfOoWRMy0FtIbzdXE34eW3ZmR2OLjgJM88RmhC4OSnzCcxbYTyVLmzAyQB
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;6:iUugSgLzHdPsnqnZTkz0mGDzpgX5XbaKQIm6/lgPS4TEwordIMrIAcL+G8gWUl7uVOyPJ0cvfIVaPCbCZVJg4qIlabdc8+JGbOo5oOxJ9SRV8lRPKYIflbmJAfcvTYttTQFdLclXDv0eyvmVhzAsjmrx57NNNSKaOqs7tHTfUj1OP9xP9ie4biC9fP3NyB/ecdzxONSMP+DVVVkLHfs6TIFAx5LOLvKL8TROaLEgHzLZknUShSp+J6MZ0PAajQvE1Nt9R1POhv8jb9EFOhVxbKlEgkSHBkZ/bQKcoK/oWnvUvDMf2llLuf2tVKiy+FkCXA0aFS/fL/S7h6i/Iv/qGljz9fAD46mL5IzNUZsrYKI=;5:iubcev8vYB5UD46sg3XAImclXdrmvDXEtPoizS67OXfPTV3rA+I8xrFj//jhwfhaedb4ZU8ngRMvqzhdYsfFFYIkU/Uuk3stjgcfIRvRwdFKXGOg5xmcsmBl+xVwofwZJx7pD3VkcHVWqbqK/pMhnJSJh6FGMtI59YWsTPv4ZQI=;24:D1PNSr57K4vh1R5t/23LIkXIELFQfVMyYO8xzl5Y4nqChpOcW3cUHhHfwYP/kdhiq7GjJCUHLIat0i2OcDNi2/T8vEM9piB5wixnloXtu2I=;7:tbUij5y9sWcc7JxFSkGpIoZNjWCmUv6bueW9fOX5wNRoI6p4PJAkZmclerB30JFBi9VGxHEMY7GHGnqIufmYWts0y5PSXZB6sV70TMEitzGncscr4wklKXKoQtn45zRbPvalGa2XtTURne0+b89DCTbsv1dkzSVwK5gPQbU/f1ygKRcgcde7XAjwNr8h8A6dPrmx0Zg3gnhfqLl04M2cgATFYVfZNzWRIg5jQbXCL1yuOGoHVmSGA+AB/9oGyTW1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:8LvfxxX+xYTHgifVS9D5ESCKNZ0slrgC/xyog5SoQQ9SgxOlKqgFqWy9XXdSRwYtUfYO6prfXf0BvpnLcO1OLb0MzOJenyhLxYTkgmSJXZH2the549csUeoW8aKArRK6/AxWn/u/Y9Jl5qjLWCPcl3wX13bE6O0kSre+a/AOGBI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:32:39.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2f3571-08d7-4355-073f-08d585e3c290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2507
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594482270766021728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 8:24 AM, Andy Lutomirski wrote:
> On Fri, Mar 9, 2018 at 3:39 PM, Alexei Starovoitov <ast@fb.com> wrote:
>> On 3/9/18 7:16 AM, Andy Lutomirski wrote:
>>>>>
>>>>> On Mar 8, 2018, at 9:08 PM, Alexei Starovoitov <ast@fb.com> wrote:
>>>>>
>>>>> On 3/8/18 7:54 PM, Andy Lutomirski wrote:
>>>>>
>>>>>
>>>>>
>>>>>> On Mar 8, 2018, at 7:06 PM, Linus Torvalds
>>>>>> <torvalds@linux-foundation.org> wrote:
>>>>>>
>>>>>>
>>>>>> Honestly, that "read twice" thing may be what scuttles this.
>>>>>> Initially, I thought it was a non-issue, because anybody who controls
>>>>>> the module subdirectory enough to rewrite files would be in a position
>>>>>> to just execute the file itself directly instead.
>>>>>
>>>>>
>>>>> On further consideration, I think there’s another showstopper. This
>>>>> patch is a potentially severe ABI break. Right now, loading a module
>>>>> *copies* it into memory and does not hold a reference to the underlying fs.
>>>>> With the patch applied, all kinds of use cases can break in gnarly ways.
>>>>> Initramfs is maybe okay, but initrd may be screwed. If you load an ET_EXEC
>>>>> module from initrd, then umount it, then clear the ramdisk, something will
>>>>> go horribly wrong. Exactly what goes wrong depends on whether userspace
>>>>> notices that umount() failed. Similarly, if you load one of these modules
>>>>> over a network and then lose your connection, you have a problem.
>>>>
>>>>
>>>> there is not abi breakage and file cannot disappear from running task.
>>>> One cannot umount fs while file is still being used.
>>>
>>>
>>> Sure it is. Without your patch, init_module doesn’t keep using the
>>> file, so it’s common practice to load a module and then delete or
>>> unmount it. With your patch, the unmount case breaks. This is likely
>>> to break existing userspace, so, in Linux speak it’s an ABI break.
>>
>>
>> please read the patch again.
>> file is only used in case of umh modules.
>> There is zero difference in default case.
>
> Say I'm running some distro or other working Linux setup.  I upgrade
> my kernel to a kernel that uses umh modules.  The user tooling
> generates some kind of boot entry that references the new kernel
> image, and it also generates a list of modules to be loaded at various
> times in the boot process.  This list might, and probably should,
> include one or more umh modules.  (You are being very careful to make
> sure that depmod keeps working, so umh modules are clearly intended to
> work with existing tooling.)  So now I have a kernel image and some
> modules to be loaded from various places.  And I have an init script
> (initramfs's '/init' or similar) that will call init_module() on that
> .ko file.  That script was certainly written under the assumption
> that, once init_module() returns, the kernel is done with the .ko
> file.  With your patch applied, that assumption is no longer true.

There is no intent to use umh modules during boot process.
This is not a replacement for drivers and kernel modules.
 From your earlier comments regarding usb driver as umh module
I suspect you're assuming that everything will sooner or later
will convert to umh model.
There is no such intent. umh approach is targeting one specific
use case of converting one stable uapi into another stable uapi.
It's all control plane that can be a slow as it needs to be.
Critical kernel datapath is not going to be affected
(especially the one needed to boot)
because umh is a user mode app running async with the rest of kernel.

With patch applied there are still zero users of it.
bpfilter and nft2bpf are the only two that are going to use
this interface. Every other potential user will be code reviewed
just like everything else in the kernel land.
So your statement that with patch applied there is an ABI breakage
is just false.

At the same time I agree that keeping fs pinned while umh module
started from that fs is not great, so I intend to solve it somehow
in v2 while keeping the approach being elf based for
debuggability reasons explained earlier.

> Heck, on my laptop, all my .ko files are labeled
> system_u:object_r:modules_object_t:s0.  I wonder how many SELinux
> setups (and AppArmor, etc) will actually disallow execve() on modules?

I don't think it's a good idea to move lsm into umh.

> Can you please try to have a constructive discussion here?

I'd like to ask the same favor.
Claiming ABI breakage when there is none is not constructive.
Saying that "ohh there must be a security issue here, because it looks
complex" is not constructive either.
