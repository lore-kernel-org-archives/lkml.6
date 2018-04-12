Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDLPAm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:00:42 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:28756 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752979AbeDLPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:00:39 -0400
Subject: Re: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
To: Mike Galbraith <efault@gmx.de>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
 <1523332961.4827.1.camel@gmx.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
Date: Thu, 12 Apr 2018 10:00:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523332961.4827.1.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: DM5PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:3:7b::25) To CY4PR0401MB3617.namprd04.prod.outlook.com
 (2603:10b6:910:8e::39)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY4PR0401MB3617;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3617;3:Q1kNvfcepHDKUwPPzz6ctcpsvrxHMbx+Wk2nFqt8l3gO9JxeT4Gp+XbUCwWqwc1aN2PxvqoxQb8U9yhjUAYSpfY0fwYJHpTfqABdzPWSP1Sz0JMl0QP0ImeTxSFjsL6MSvU67CqANgxo+12YDNEwVjDgUgrSpyz0r7uROC5qm4vMdFaJdxUy6oUhfnVWb++cNCO2aVBCIww6KEBIvGQdYShCviaqWSC7M425nSnFvqMKRlfP1OHurV0rbG2yo9yt;25:bMG9qMHsucNuRY7qI71gfN43EDZnId+vlifgKdYrz3+jT76Qr8OT3dCbv1ICVRl23ufIw3qsIYW2nxVa6bv7Ttyl8XqinI0Q+GS0jHV0qlJZR+S80qKs4PzVYjNNBAlyLSqeZrfVrseuYR86Vz1FO6RrV0iODmltctTz39w2wX7bdojJmsOatSC+7EaSt00HT2EOyNEqD9pQdfeoRzkhw9RiHiXV6a2c8mLMacqQUlaD+KSRtkP6xCQUIMUBgXIe25gWxeZBvAJqMobDb+9LGOLYiX5rIRXR3//GnPUrs4mUXpyuIWJrSePs8c9lF1PSywua4yLnP+93R8w83wJ43g==;31:oVzZ0ukg8poXP4nXHLB6nOhJC1S7Us/vnYI3sziT8xJmKxecPlp7X9JFx0Kd231tj4twhen1UoTUU6TmvM+lKW6aN9fIMch7Itkqe3k/NUF68gPDq25H4sxKZ84DKrz9B1uj3N6C9zWlJ0xY+CGRYNKbDjEemmaE3+NRGvAdTNQC0Vyenjx6qFUx2WDI59q1pqzfi1J1JF4kjpspzKLJ9IKaXzBPMW9LVTUwrCEAV+A=
X-MS-TrafficTypeDiagnostic: CY4PR0401MB3617:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3617;20:cpYKBV/BkBGdwwmmiAo3+h4udkWuUu2RIA5bC6297XKcbxWFuKvE+ULyvzund4Jnhn3tNGluQcZqC3CeCUuGvziS548ExpUBH7W38CJgPj80PP6dwVG0fiWLR1vB90QwiZrZyGKBx+LdRbMuoRk1sqNEajfuvJHlcYDwY5IxeStUQtpCnVUBP89MCNiUna2qKKaTyvA395BPCLhkXHmdPoIt6rcyGeNuUzpqKMlQk5YuUVNlNZDOKmZKjnpYgIOB3DSGj1fo85BsZj8oh3cCBzmelbJTrg37QtV/SN8PjWL97nA0fjwvMKUmoELdyEZ4AHrQWsQWEArsVWERjFURFRGZOnfMYQNqRdkla2BTP+Rv1GZKpplr1H99O+BH6Ci4GcQ8y20sKGhBMuJ1VSiUNu6GdR9lugcy/LNmN7iyWmsjD+YFzR7vem/p2KqQHcBafMTuwMDZlQxVv96t+CtKA/UpbOUv4bWqArjhmh7S01fcwqVUk63+soK6Q1UvVyZB2yThhaRYmw+bvLdzFtqF3GT8XwwIkk9D2lpvXxzV0fHMmrYBSd4zu4L+erMUOisQfwJuqqIgEEie1hx5ZLfOVEA3iZwMJtOaQmOV+put/Hg=;4:kCr/UpJnrIlw3pkZUHy2Z5p4ohV4FvqN3wDW4W8vKTgWgocqLHMfjUCEYsrSuJi+Y6kkNztlzKSBx2jQXHmO65txaACqjCWmx1VlzFuzbgWggldEJ+xl7k3FJFkloFn9rdtwnlYXSjjrfJ4UoYKfLaeLQ9EeRP9yIgltY1oUTA+I6zi7eDmyHJ/SPWx/Qtk8eZTE15JqOcctsHdKjKlyxObcbtSjdeQjtn0qnhZpDFApMPPW4NPspu4kw7WBjvBDDEYW72dqdRvoASPF8J2sPA==
X-Microsoft-Antispam-PRVS: <CY4PR0401MB36175496FD3BB1C231024015E5BC0@CY4PR0401MB3617.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR0401MB3617;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0401MB3617;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(376002)(366004)(199004)(189003)(76176011)(386003)(59450400001)(68736007)(8666007)(6506007)(478600001)(7736002)(26005)(65956001)(229853002)(3846002)(66066001)(47776003)(6116002)(2870700001)(50466002)(65806001)(6486002)(65826007)(67846002)(2906002)(6666003)(44832011)(53546011)(5660300001)(8676002)(52116002)(6916009)(23756003)(31686004)(81166006)(8936002)(97736004)(105586002)(81156014)(4326008)(316002)(305945005)(25786009)(446003)(6512007)(486006)(106356001)(36756003)(86362001)(58126008)(575784001)(186003)(6246003)(956004)(16526019)(64126003)(31696002)(11346002)(2616005)(53936002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0401MB3617;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-15?Q?1;CY4PR0401MB3617;23:qockLqAjPN0CoF5CZ9nKqIAGglcvScE6RUI4?=
 =?iso-8859-15?Q?YXO545V0/OV0djgJd4C/1UvlT9OusN2kmQUZa6rWMxfeefypRTEklxNrj?=
 =?iso-8859-15?Q?T25oI8Q7zuO56R721EBIMcTHRp9XLJThNWM8CV2Gc7sjWWJzZRQ6FGwI1?=
 =?iso-8859-15?Q?KWUZPxb86/ONXP58ez/CzCIRy7CtYrgoYjAKr7sMRABzS84Xu4ITBGvL+?=
 =?iso-8859-15?Q?sLGMdZ82FmXiuLRKXevOUi7wHoDFfxvMBb1Fr+t30RgFkYdHciu3v27CW?=
 =?iso-8859-15?Q?TcVGXHWxTeyVJwdq2F2V1HVY0uJ/hTr3kLVewg8YVoIAT1p2EbEYan3MD?=
 =?iso-8859-15?Q?lFvHxcgbHvlbPHgtHzydsq5ZqySp+1wtt78nujkqJzFg1ymGHEqxCYDYZ?=
 =?iso-8859-15?Q?GGvX8eE1AfamkhjM3wzuh6sHO5IKYlrZ/8DZ/1hkBCZEa8EuE2+zqfXj2?=
 =?iso-8859-15?Q?OPsV3iBvMEAlpmfkEbW2P7PfzNLvyxNeJb6DV27qF1hOIL+lCFv8QJoJh?=
 =?iso-8859-15?Q?/rZKhQe+a9z0l7OlzSmnCsVEpfJ9adYTn9GFuacLkCJwJ4qVuKHyvnyBk?=
 =?iso-8859-15?Q?bhN1HsYrsNB1Ok3RbcMJ30eYjw23Si6f7BpBc35thW7NsKq9506CeLxK0?=
 =?iso-8859-15?Q?PC/oZGGnLbOTEqbYjSpksAoSigjCboQvbwgK/BkRQJ6pBuoOLUeGWMtMl?=
 =?iso-8859-15?Q?Xe1wyLERCWr6MFcTVYxL4iK7g2VKSQ0yQ6kDzHSHQKjVlFTF/jB6p4JCp?=
 =?iso-8859-15?Q?5g4kQbO1iFqzni5ziYY76b4a9BqR4+BbjREnQf7ArKY4ZJguaM/B3fC51?=
 =?iso-8859-15?Q?HRp+di57zBrRKnZ+ZFXEKOomdwH7jtaOtR0+8GAECuzpCh7zCIcRrX0QO?=
 =?iso-8859-15?Q?8QaIMBS/pM9G4EYw+OBgcynqQmwegXPnoF9vsw4MbwlBdm3wP3fb9goKd?=
 =?iso-8859-15?Q?5mX++wDqfXuMJdUPM5bibeqmReOfXgcUv6Ody0aUKXHT+DW2QpJJRcvVI?=
 =?iso-8859-15?Q?gXW4j/ZJz3+ZzUuIBZ3zwaPDOjAAK9xkpWfjlltj4+f17TVsxxdDdyhXx?=
 =?iso-8859-15?Q?NhJlD+yGro1bI1oYkc0jBxN2dm01KOhaYHLPbt8sLHuot2RUaCSp8/9hz?=
 =?iso-8859-15?Q?AJlUx3jiQqokbQ9DUwVb1I8WlDa4WF0W7jQM7ySTc4Vw8IUyY0lsDb3It?=
 =?iso-8859-15?Q?Sr1sVCfLHod0XDvxaFE4Xyh/I9oECWTMW+nqUdNOHeBu7KIe8RV0h9e0b?=
 =?iso-8859-15?Q?8lmmNRNVRo4ievyWd2ZBxf86t6bhSMVQnJjnx9k/qcJhFVhwHc0quZGY6?=
 =?iso-8859-15?Q?B25uWmoivN+nmjiaKQpnsqy0cPL8m/SO0r7IB1XZy/pn76H3k/JE3x+aj?=
 =?iso-8859-15?Q?PVUvzwMhr7S9JvBa7viHhjevzNP6zVLDR3H1uK3xlQslm/1UugntH2aRW?=
 =?iso-8859-15?Q?USPixr194J/9kcqWeJuZt6SioSQOuFTTI65zk8HFuCFNfackv3DlO1p9N?=
 =?iso-8859-15?Q?tdicRErLRBfVujaQzxPdg65/Dyk9E3Twv75uAmtLeZLQ9D2jtNaCwU9qc?=
 =?iso-8859-15?Q?8ThkiY3IkB1?=
X-Microsoft-Antispam-Message-Info: WqEHC86vYm1IS82NAfie8e+PINFV6YyNBa3XrUdXfSxDaUqY3rFtlgv1kZ3zzEAHs314eyINB3laBheLedhQifpcG8jFayupfxiF1k5i4upap009H01lOGztEOHVDCM0Il0fAs/po9cnRIJku/ExgzQXUE1JNbuGXt3wDFn74wiiJIw+XnZtUvVu+H3U2CLq
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3617;6:SWy2kNwYUMKW+1J/8Y+KuDB6Sk5heCruWnReqMJsci5isM7qfHAXFO1vkBK60yIgQOVnsqx83wufK9HZK/CysRB+oQvOmpf+GMJzcugtE8guOXqhJc1E3IZnSC4en3QTZGD0bwv4Ur0cELYgr92Yd4fjBbEi9zWSCquhUVVpOIWl4922Jci3shz3P8Xd32i2pcOKnteJXyOa2Qesc0ugvePssYxEqqxWjzHkCU5nlMDjmG5L53M32LuRS9ooAQrluciaOHN0ba738V5hpadw6hIO7Dt+CUi/2/sbGq0EGIT4GqbTVILHW5OoQVP4hEXcN4qkgRlEpz6LEivve5g1mfiMYKZfHmR7+Jhy/ZUvRsvvmw0GineKM6IaYHx2zHDOn7qx444duUmuIgfyFGNpSb66kXk9TSG9AJGGt88jcjLF5VyDJ+rSyFECUk+A3KcIrWGSK7HYT5qmwhsBgvPL1A==;5:AJwr2WpUYqinyefSVUuzblyEmJEHAzTvnHb5QJBabLI+9MuWM8VuTi7j7DSBvblPIq7KvOG4+AgNjczejCcSSP8VZNxsMaiucYQR+XUbDD9twmXN6IMp41JiPX4POhK7wlPqYr4BLHiiX9tHxwy2CVXZi8QfqO+b43iXWSKsQ2Q=;24:bpY21UI7bk0tikRQUF0YzgAbL+8/XvHnlIPXtlcVJLokJQWVD+//xpsT1FHZywkLi5suBKfEZ/GjQbfv4aAdG6yxmKUJTanSUUIvAJ6fkis=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3617;7:TSR6zwwk8qvAOFyrwop/im4MY0Vb+eghdc+iyGwz0EzGiC9OOG8B1fSt7aRBDXVA83rhCU9wioa2kMgZXOIPvRfx+ZIBtGvbKCKoSDt920/dGFulpNljrvgAchteYHhn7EuMuE0qQV+e9BWfzSAA96D0r38eX25u83jq0FpsVhTng7D/coSOYZ7cwxnJeJwiNM0s6h8dhVBHvLGr70n5pQp+Wa/0f4xvDBXSSxN6bfLJZdmsD4amOgyV69OskSz+
X-MS-Office365-Filtering-Correlation-Id: a1a65bef-0376-4b4b-1b34-08d5a0862471
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 15:00:33.7747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a65bef-0376-4b4b-1b34-08d5a0862471
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3617
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804120149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I haven't tested the patch with wireshark until now. My system also 
hangs shortly after it starts. I'm pretty sure I hit workqueues in my 
earlier tests via the block driver, but it's clearly not whatever 
wireshark is using. I'll look at it and try to post a fix. CCing the 
list to avoid this patch until then.

Thanks,
Haris


On 04/09/2018 11:02 PM, Mike Galbraith wrote:
> Hi,
> 
> Are these patches dead, or are you planning another submission?  I ask
> because I discovered that with them applied, firing up wireshark hangs
> the box 100% repeatably, with wireshark never fully initializing.
> 
> Applying them to an otherwise virgin 4.14.20-rt17 to be sure...
> 
> crash> bt 6016PID: 6016   TASK: ffff95dd68572180  CPU: 2   COMMAND:
> "dumpcap"
>   #0 [ffffb490094f3bc0] __schedule at ffffffffa56d55b9
>   #1 [ffffb490094f3c40] schedule at ffffffffa56d5a03
>   #2 [ffffb490094f3c58] schedule_timeout at ffffffffa56d8467
>   #3 [ffffb490094f3cd8] wait_for_completion at ffffffffa56d6e34
>   #4 [ffffb490094f3d18] __wait_rcu_gp at ffffffffa50e59cd
>   #5 [ffffb490094f3d58] synchronize_rcu at ffffffffa50ec14e
>   #6 [ffffb490094f3d98] packet_set_ring at ffffffffc0c74da0 [af_packet]
>   #7 [ffffb490094f3e50] packet_setsockopt at ffffffffc0c75d23 [af_packet]
>   #8 [ffffb490094f3ef8] sys_setsockopt at ffffffffa558a5e2
>   #9 [ffffb490094f3f30] do_syscall_64 at ffffffffa5001b05
> #10 [ffffb490094f3f50] entry_SYSCALL_64_after_hwframe at ffffffffa5800065
>      RIP: 00007f3107a1cfaa  RSP: 00007ffc9745c2e8  RFLAGS: 00000246
>      RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f3107a1cfaa
>      RDX: 0000000000000005  RSI: 0000000000000107  RDI: 0000000000000003
>      RBP: 000055ae1d8eb470   R8: 000000000000001c   R9: 0000000000000002
>      R10: 00007ffc9745c350  R11: 0000000000000246  R12: 00007ffc9745c350
>      R13: 0000000000000000  R14: 000055ae1d8eb200  R15: 000055ae1d8eb2d0
>      ORIG_RAX: 0000000000000036  CS: 0033  SS: 002b
> crash> dmesg
> ...
> [  483.808197] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 nice=0 stuck for 52s!
> [  483.808204] Showing busy workqueues and worker pools:
> [  483.808206] workqueue events: flags=0x0
> [  483.808208]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
> [  483.808211]     pending: check_corruption
> [  492.695124] sysrq: SysRq : Trigger a crash
> 
