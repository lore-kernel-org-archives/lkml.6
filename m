Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeC0WG3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:06:29 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:11292
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751070AbeC0WG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:06:26 -0400
Date: Tue, 27 Mar 2018 23:06:14 +0100 (BST)
From: Michael Young <m.a.young@durham.ac.uk>
X-X-Sender: michael@austen3.home
To: Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
cc: "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: NFS mounts failing when keytab present on client
Message-ID: <alpine.LFD.2.21.1803272126070.3013@austen3.home>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Originating-IP: [81.154.211.231]
X-ClientProxiedBy: VI1PR07CA0130.eurprd07.prod.outlook.com
 (2603:10a6:802:16::17) To AM5PR0602MB2802.eurprd06.prod.outlook.com
 (2603:10a6:203:95::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b6a3d49-4729-42ef-2961-08d5942ef987
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AM5PR0602MB2802;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB2802;3:FyVGI5OTRq4ZtUcU9ve8WtEAFfQERljw767nuN4tsBHZLsp7dRodzBrpeyHB4gplOhPh0og5sIv3lUUAhyzM/tk4ACukLyMQBZEqS+fZqksYQAIPrsBM4XtvPJHPlsQl7YjBgrvwFkD+kJA4LpddrWMWZHGXwMOBZzS34UobAjomwPnfHGsHomReZiUZudzQxnQDp40DMImhIjeFWBRr2GpNCTLUyf+ykJv9CAE2KzpQ8zcPAnVj28J1c6zmepcJ;25:wuJHRGiD+M4KUQVOgZFYehNgKTqs43yWq1TPbsHKCAfW1etQjfLE5tsn9HF4+v8q4piEmDUDwjtigBdFkxheUsuvaSSBuj27v1HB42C2l05AsFeQWLJhgHPmOQWApbueii6XDLGDYp50HG7F/iMlWF7Y0mYm0hjdUWjj0I+Es0kvB8LdQwtlZs3PyVJtNbXnNNajdz4hyo89qFZKzdnFRXE5DuondxSDM28rPYdwMooePiMAL4ZwrEb5dGT8+UnWPHKB/PcjyVGmGkj+L2NZWOuGEB77mLXZuvulHrfYHNyup0ryZ/RAwzyKHE3XAvQTFcjODGn8qOf8UY/yZsIULg==;31:epGWf7FLI49JYVD+j4y3rLO+oITxBAAXg8Vh4bFbzolza734rpK+XIG1SwWyHF32cmKIAL3diukeLBQBx5ECjCOGj+k47EWa1AJf0zfc/mmm5TeL9XBpNYQfrqu+Bsh4nvMtWhHzHFiiSbvfAoH1hQ50vHNlTi72hcbqGxm0Sni+5bNkAcgWsUvGZfoV/5NuMKnxgjC3AUrCoucTaTpkipQ5fMljIepsBPC89keNYOo=
X-MS-TrafficTypeDiagnostic: AM5PR0602MB2802:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB2802;20:g3OVwOHE8tcBwuTZn9/48En+AfEo80BY0ok/9LjN3tC4CJClHX4yzSWeIUVpqKNu0HlJKs2IJ2gD+OD5tLbd30+PUNthUhnrE5TYvmsa6a0FBHp6dHQ9lwXWzs/DoAd08DNd3HRwAzxVr13/xDf1FU96paDD7BDBpHmkmR/E0nKJEPiM9qGIiX+N0BPQx7Z0KjJbzjvHg5xjRRH8VjlYsSVnQUGJgEZjT9ckyxvisTIQKDNazLIDLpgn3O/AGDKt;4:c68bWneKt7l9QtSZGdBZMINdjvA23uWOT4qxyGjaKv5rAv9tWWfkjzq6DFozmGCrxhhPRlsMwZM5aTnD8K53KBWtDuNQEKHlr5MR8HnuSFgeQ0P7Qw4qxNcNBZ4MVdMJ6WjakT84UayzBZUFa2AXaLz7GGE4C5wz7mGHAjLaWwJFTcps+CXI0Bv67tavqUa5Rn4zh/i/4Ndzr1t6GALiEW8aT2Bwr82xOT5bmiqEWUr0otkCsAt8xRyjhuHr0dm/UOvcHiUxSqikpQhJpgxA2A==
X-Microsoft-Antispam-PRVS: <AM5PR0602MB280253AD4E6668DE6AF93A6087AC0@AM5PR0602MB2802.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0602MB2802;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0602MB2802;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(189003)(199004)(8936002)(55016002)(81156014)(7736002)(50466002)(23726003)(106356001)(5660300001)(105586002)(81166006)(8676002)(6666003)(97736004)(3846002)(6116002)(53936002)(2906002)(9686003)(26005)(16526019)(476003)(305945005)(59450400001)(67846002)(478600001)(486005)(386003)(110136005)(54906003)(86362001)(58126008)(16586007)(486005)(47776003)(786003)(36756003)(316002)(69596002)(21086003)(6506007)(25786009)(6346003)(66066001)(68736007)(956004)(4326008)(52116002)(74482002)(186003)(7696005)(5005980100005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0602MB2802;H:austen3.home;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=m.a.young@durham.ac.uk;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0602MB2802;23:i5szaaf6szn6cquDB2U1+GVlFYCC0cNHBzEwjPL?=
 =?us-ascii?Q?/j9H4wDtY6GZqbDV9NmbkHTVLDygPl+KfwAEx5oYk/OK+eSi7UzWESJxSJuR?=
 =?us-ascii?Q?lDpU2kWNBXtX0J9kTG3YnuVigg8QYkemjiIbOXikqu5FzZ22SbSYDAa1M8oq?=
 =?us-ascii?Q?iDRxPHZjqFa4JoL0N2FUzB1P/TTc9sf8/G8DJe3NtOfkJuapDznd2BY96LMK?=
 =?us-ascii?Q?i/QbCzkuYBJ2e9rIn9T+TfEIXgJSdusXPTLXKry28qYSOdC+R1Ei5DLm9Rg1?=
 =?us-ascii?Q?z0gWykKcQswE6eU/grFh1WJj3Jhs5iOdQbN4iOkQDX3OzmOydyq+M2cle23l?=
 =?us-ascii?Q?H1un6+yXUxKGJ3QcLE7eJry/hHbLUqia3d4fc9z9wPgtjZ/L9upaPfqxiKK6?=
 =?us-ascii?Q?5inrm+jnUJHAVDamnnQX1NCFMeEJPk/v1gUY1veLIhjcIpW//myX4q+9JmHc?=
 =?us-ascii?Q?7u3YqkJvDI/IsF6zl7qMXbV/pmjYTkfmfiO2ax+Z/z9l03oiY+tdZYWIZVou?=
 =?us-ascii?Q?HrFtWSG8RlHMAEEvhI39xroT/JUO24nT8lSnQK5d46Q4sitxGe6Zqnyoz0qc?=
 =?us-ascii?Q?ul7hERSomBGI4IdMcwkwk8vf1+/uEImXO1FpQn/SMpdJErAt3C+Tm5Ilst4c?=
 =?us-ascii?Q?P0UvpIyWmHtj6i7DB7xpZ+tj0cEifHnJJ+F6/UvKB7NQq1CxS6M0pN/KA1i+?=
 =?us-ascii?Q?gti09h7GEW3SMPj0l17dUPi/41jZsoD0qMJ182ExsddtoXx5a0TVl4Yt2o7O?=
 =?us-ascii?Q?yUJt6+S7rPZLf6nrZXZMk+2HxhO30lRmIiXWo97FTAPTUwXolOL9Jf+JGqae?=
 =?us-ascii?Q?aPMerQi8hfj9PhpTM24+3ljUOC39YG1oL8QcLqu3v5z/wEeqbeUEIEO0xd8S?=
 =?us-ascii?Q?z/+beLWZMS2xEUKQGpD0pEchWtehhBRojRZ/X6drzIes0BtAtaUYSdL/p8WG?=
 =?us-ascii?Q?yzCtwLLEO5DVPJWYzf2PmjkbVTY2FgCKOHqMrPWGmSxYjGG2pj7+wq2R5oeD?=
 =?us-ascii?Q?ovZn6tZulvrORSxLDZo1mKUr59iLbD4mWX0QD1AAUBnb3c7NPL7/5JwaJxoT?=
 =?us-ascii?Q?E0mUeAgCDUbJRhCIS6jiWdeSyda8P5ZESp4amM5zKNhjsYHOuN/XdZkKbYsF?=
 =?us-ascii?Q?Mvo3lqoUtZgfmEWrQjDVufP8D8eiYvd1PXSIhkyJYoQcCyk2/3OVFBr48DVS?=
 =?us-ascii?Q?1/Rmw39DJ+gWLvqrjs223fmTn/IxYyDLPkVzMkLsnzpFKEe6yYJ9uwKOdFyM?=
 =?us-ascii?Q?N6ExfMiL3trFvx0VpL/KOzq82TtwltVPNjrw33olUwoWq0gpRIWX0y28bG/A?=
 =?us-ascii?Q?r9Q5BcvxIDf8+skX165CS+to=3D?=
X-Microsoft-Antispam-Message-Info: nUtN4vr0imcBMN8wsM6juqYmITKrOVvLXzYRyN0aNcR1LK4pT1wVYiduiBCceY0NA1Wc3qs/fDGrsoqmMtbo4MP56MrwkNNXcVEmfwuj5JgO6VyprUfSCnGNbUjJwfp1S6kGdUMX7o5UisDmmM+n5x6J39o5KLQWVkfQBzlpf5Mx4nvNJk38YLGP3XognWPw
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB2802;6:xzYQOX3yVF3CRrqUsCJKwIvKol3SOdwwwNok/pOXa4hpfM/DyGDjHMj5FtTTd8ZEz+7JxA62r2ehF+0XxesBL8ifqKTd5CYl7Vw0hqn7G0hqA6PU+UDmEaIy7TL5TA+1/YNZji63oVLON3xRMfxBPAPhC37kYyMAbgHkQRPP42nngvQ64p+9sviL/aglg5e7NwBinwP5DKPdF7VWz16vJvY7pN527oIkcYhf7eQvd0mPDmN+cgJ9NDR73NL1Bx60uU1fRTj+jBpDNAfq5ctPT9bXlEu1nnTf3Ns3pS8glDpQOIvPbP128pdAZKEIqeBu3Hp9mOAv5WBp1SmlIfqFb04Sdsj8J64k7QxPSvRmvUg5CR/HW9zoB8XIoysbwRWfHduhGCwjugPUR87MXlDqHGRZBNBfg25GxQ1R7D/UkKrhFYEELpGRqTyFCL8O999lCJjhZtdfvqqp701jbJB0hA==;5:qpNrKYXSHhbZVGd7UAJRngMG5uRKIqOGr4cnZxqTfP6hb80u5/atXbykQYqT5LOXYriRc3LOQi69J2wfRSPIe+DiWLsYOjinxLuoweK2s+KPcq8a6rTICfOqSZUovaLiyFC9oQ/RHzVTUIa3mErfACGJUHXUyj9WAQa4pAJc/1k=;24:nqPGGGFuu20HdAYOCCPX4LtzPSFksQ8SJE4GLG0NRi6rFfcNYdiemfot6jZaetUOWZFpsTnj91QT52g3ReJp7EZEb/msYH3seELUOsIRzJA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB2802;7:egGxa2BAGW3mig4zfxSab5w5ajnm6Jpi5GDoIkYI6C/IWtoiOXNDmYomLlf32joT5Sm4gRY/5iiQzLdlgtw3ZSz8Afp+Y3E9SqBoBgXbZ3ecBuBmxthsLxXainj0V9THH3xTM5lBgr1rXPqz6vEgwMidt8RXngUS4ygmRWDl6hiv74lwKE7+Bag1/v5Qg9TGzW30cno8fjYBT10sSpuqqTBQ4b3PKyKwK3ob2bKhyH9nBh397f/dWCy7udTdPBMF
X-OriginatorOrg: durham.ac.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 22:06:20.9897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a3d49-4729-42ef-2961-08d5942ef987
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7250d88b-4b68-4529-be44-d59a2d8a6f94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0602MB2802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFS mounts stopped working on one of my computers after a kernel update 
from 4.15.3 to 4.15.4. I traced the problem to the commit
[46e8d06e423c4f35eac7a8b677b713b3ec9b0684] crypto: hash - prevent using 
keyed hashes without setting key
and a later kernel with this patch reverted works normally.

The problem seems to be related to kerberos as the mount fails when the 
keytab is present, but works if I rename the keytab file. This is true 
even though the mount is with sec=sys . The mount should also work with 
sec=krb5 but that also fails in the same way. When the mount fails there 
are errors in dmesg like
[ 1232.522816] gss_marshal: gss_get_mic FAILED (851968)
[ 1232.522819] RPC: couldn't encode RPC header, exit EIO
[ 1232.522856] gss_marshal: gss_get_mic FAILED (851968)
[ 1232.522857] RPC: couldn't encode RPC header, exit EIO
[ 1232.522863] NFS: nfs4_discover_server_trunking unhandled error -5. 
Exiting with error EIO
[ 1232.525039] gss_marshal: gss_get_mic FAILED (851968)
[ 1232.525042] RPC: couldn't encode RPC header, exit EIO

 	Michael Young
